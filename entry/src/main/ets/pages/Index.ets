import { BodyTemp } from './BodyTemp';
import { Calorie } from './Calorie';
import { HeartRate } from './HeartRate';
import { StepCount } from './StepCount';
<<<<<<< Updated upstream
=======
import { SleepTracker } from './SleepTracker';
>>>>>>> Stashed changes

interface Metric {
  title: string;
  icon: Resource;
}

@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string) {
    if (name === 'BodyTemp') {
      BodyTemp()
<<<<<<< Updated upstream
    }
    else if (name === 'Calorie') {
      Calorie()
    }
    else if (name === 'HeartRate') {
      HeartRate()
    }
    else if (name === 'StepCount') {
      StepCount()
=======
    } else if (name === 'Calorie') {
      Calorie()
    } else if (name === 'HeartRate') {
      HeartRate()
    } else if (name === 'StepCount') {
      StepCount()
    } else if (name === 'SleepTracker') {
      SleepTracker()
>>>>>>> Stashed changes
    }
  }

  metrics: Metric[] = [
    { title: 'Calories', icon: $r('app.media.calories') },
    { title: 'Heart Rate', icon: $r('app.media.heart') },
<<<<<<< Updated upstream
    { title: 'Step Count', icon: $r('app.media.step')},
    { title: 'Body Temp', icon: $r('app.media.temp')}
=======
    { title: 'Step Count', icon: $r('app.media.step') },
    { title: 'Body Temp', icon: $r('app.media.temp') },
    { title: 'Sleep', icon: $r('sys.media.moon_z_fill') }
>>>>>>> Stashed changes
  ];

  @Builder
  buildCard(item: Metric, routeName: string) {
    Column() {
      Image(item.icon)
        .width(30)
        .height(30)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: 5 })
        .fillColor(item.title === 'Sleep' ? '#FA5352' : Color.Transparent)

      Text(item.title)
        .fontSize(9)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
    }
    .width(50)
    .height('25%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({
      top: 2,
      bottom: 2,
      left: 1,
      right: 1
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.pageStack.pushPathByName(routeName, null);
    })
  }

  build() {
<<<<<<< Updated upstream
    Navigation(this.pageStack){
=======
    Navigation(this.pageStack) {
>>>>>>> Stashed changes
      Column() {
        Text('Your Activities')
          .fontColor(Color.Black)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 10 })

        Column() {
<<<<<<< Updated upstream
          Row({ space: 10 }) {
            this.buildCard(this.metrics[0], 'Calorie')
            this.buildCard(this.metrics[1], 'HeartRate')
          }
          Row({ space: 10 }) {
            this.buildCard(this.metrics[2], 'StepCount')
            this.buildCard(this.metrics[3], 'BodyTemp')
=======
          Row({ space: 5 }) {
            this.buildCard(this.metrics[0], 'Calorie')
            this.buildCard(this.metrics[1], 'HeartRate')
          }

          Row({ space: 5 }) {
            this.buildCard(this.metrics[2], 'StepCount')
            this.buildCard(this.metrics[3], 'BodyTemp')
            this.buildCard(this.metrics[4], 'SleepTracker')
>>>>>>> Stashed changes
          }
        }

        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#f0f0f3')
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PagesMap)
    .hideBackButton(true)
    .ignoreLayoutSafeArea()
    .width('100%')
    .height('100%')
  }
}
