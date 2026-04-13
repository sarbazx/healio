import { healthService, healthStore } from '@kit.HealthServiceKit';
import { Callback } from '@ohos.base';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct SleepTracker {
  @State sleepHours: number = 0;
  @State lastSleepDate: string = 'Never';
  @State isMonitoring: boolean = true;
  @Consume('NavPathStack') pageStack: NavPathStack;
  private listener: Callback<healthService.SampleReal[]> | undefined = undefined;

  aboutToAppear() {
    this.startSleepMonitoring();
  }

  aboutToDisappear() {
    this.stopSleepMonitoring();
  }

  startSleepMonitoring(): void {
    if (this.isMonitoring) {
      return;
    }
    try {
      // Subscribe to sleep record data using healthService.workout.onData
      this.listener = (data: healthService.SampleReal[]) => {
        if (data && data.length > 0) {
          this.processSleepData(data);
        }
      };
      // Use the DataType constant for SLEEP_RECORD (id: 1007)
      const sleepType: healthStore.DataType = {
        id: 1007,
        name: 'sleep'
      };
      healthService.workout.onData(sleepType, this.listener).then(() => {
        this.isMonitoring = true;
      }).catch((err: BusinessError) => {
        console.error('Failed to start sleep monitoring: ' + err.message);
        this.lastSleepDate = 'No Data';
      });
    } catch (err) {
      console.error('Sleep monitoring error: ' + JSON.stringify(err));
    }
  }

  processSleepData(samples: healthService.SampleReal[]): void {
    let totalSleepMs: number = 0;
    let latestTime: number = 0;
    for (let i = 0; i < samples.length; i++) {
      const sample = samples[i];
      if (sample.fields && sample.fields['duration']) {
        totalSleepMs += Number(sample.fields['duration']);
      }
      if (sample.time > latestTime) {
        latestTime = sample.time;
      }
    }
    this.sleepHours = totalSleepMs / (1000 * 60 * 60);
    if (latestTime > 0) {
      this.lastSleepDate = new Date(latestTime).toLocaleDateString();
    }
  }

  stopSleepMonitoring(): void {
    if (this.listener && this.isMonitoring) {
      try {
        const sleepType: healthStore.DataType = {
          id: 1007,
          name: 'sleep'
        };
        healthService.workout.offData(sleepType, this.listener);
        this.isMonitoring = false;
      } catch (err) {
        console.error('Failed to stop sleep monitoring: ' + JSON.stringify(err));
      }
    }
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text('Sleep Tracker')
            .fontColor(Color.Black)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .padding({ top: 5, bottom: 5 })

          Image($r('sys.media.moon_z_fill'))
            .width(30)
            .height(30)
            .objectFit(ImageFit.Contain)
            .fillColor('#FA5352')
            .margin({ bottom: 5 })

          Text('Resting')
            .fontColor(Color.Black)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .padding({ bottom: 5 })

          Column() {
            Text(this.sleepHours > 0 ? this.sleepHours.toFixed(1) : '--')
              .fontSize(24)
              .fontColor('#1a237e')
              .textAlign(TextAlign.Center)
              .margin({ bottom: 6 })

            Row() {
              Image($r('app.media.dot'))
                .width(15)
                .height(15)
                .objectFit(ImageFit.Contain)
                .margin({ right: 2 })
              Text('hours')
                .fontSize(12)
                .fontColor(Color.Black)
                .textAlign(TextAlign.Center)
            }
            .margin({ bottom: 6 })

            Text(this.sleepHours > 6 ? 'Good' : (this.sleepHours > 0 ? 'Short' : 'N/A'))
              .fontSize(10)
              .fontColor(Color.White)
              .backgroundColor(this.sleepHours > 6 ? Color.Green : (this.sleepHours > 0 ? Color.Orange : Color.Gray))
              .padding({
                left: 6,
                right: 6,
                top: 2,
                bottom: 2
              })
              .borderRadius(4)
              .margin({ bottom: 10 })
          }
          .width(70)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Text(`Last: ${this.lastSleepDate}`)
          .fontSize(9)
          .fontColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 6, top: 6 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#f0f0f3')
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}
