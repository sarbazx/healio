<<<<<<< Updated upstream
@Component
export struct StepCount {
  steps: number[] = [3000, 4500, 7000, 9000, 6000, 4000, 2000];
=======
import { sensor } from '@kit.SensorServiceKit';

@Component
export struct StepCount {
  @State steps: number[] = [3000, 4500, 7000, 9000, 6000, 4000, 2000];
>>>>>>> Stashed changes
  days: string[] = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun'];
  @Consume('NavPathStack') pageStack: NavPathStack;

  readonly maxSteps: number = 10000;
  readonly maxBarHeight: number = 100;

  aboutToAppear() {
    this.startPedometerSensor()
  }

  aboutToDisappear() {
    this.stopPedometerSensor()
  }

  startPedometerSensor() {
    try {
      sensor.on(sensor.SensorId.PEDOMETER, (data) => {
        // For simplicity, we update the last day with real-time steps
        const newSteps = [...this.steps];
        newSteps[newSteps.length - 1] = Math.round(data.steps);
        this.steps = newSteps;
      }, { interval: 1000000000 }); // 1 second
    } catch (err) {
      console.error('Failed to start pedometer sensor: ' + JSON.stringify(err));
    }
  }

  stopPedometerSensor() {
    try {
      sensor.off(sensor.SensorId.PEDOMETER);
    } catch (err) {
      console.error('Failed to stop pedometer sensor: ' + JSON.stringify(err));
    }
  }

  build() {
    NavDestination(){
      RelativeContainer() {
        Column() {
          Text('Weekly Activity')
            .fontColor(Color.Black)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .padding({ top: 20});

          Stack(){
            Column()
              .backgroundColor(Color.White)
              .borderRadius(8)
              .width('80%')
              .height('50%')
            Row() {
              ForEach(this.steps, (item: number) => {
                Column() {
                  Blank()
                    .height((item / this.maxSteps) * this.maxBarHeight)
                    .width('10%')
                    .backgroundColor('#9a679e')
                    .borderRadius(4)

                  Text(item.toString())
                    .fontSize(10)
                    .fontColor(Color.Black)
                    .width('12%')
                    .textAlign(TextAlign.Center)
                }
                .alignItems(HorizontalAlign.Center)
              }, (item: number, index: number) => item.toString())
            }
            .width('100%')
            .height('75%')
            .alignItems(VerticalAlign.Bottom)
            .padding({bottom: 35, left: 35})
          }
        }
      }
      .height('100%')
      .width('100%')
      .backgroundColor('#f0f0f3')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}