import { BodyTemp } from './BodyTemp';
import { Calorie } from './Calorie';
import { HeartRate } from './HeartRate';
import { StepCount } from './StepCount';

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
    }
    else if (name === 'Calorie') {
      Calorie()
    }
    else if (name === 'HeartRate') {
      HeartRate()
    }
    else if (name === 'StepCount') {
      StepCount()
    }
  }

  metrics: Metric[] = [
    { title: 'Calories', icon: $r('app.media.calories') },
    { title: 'Heart Rate', icon: $r('app.media.heart') },
    { title: 'Step Count', icon: $r('app.media.step')},
    { title: 'Body Temp', icon: $r('app.media.temp')}
  ];

  @Builder
  buildCard(item: Metric, routeName: string) {
    Column() {
      Image(item.icon)
        .width(30)
        .height(30)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: 10 })

      Text(item.title)
        .fontSize(9)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
    }
    .width(50)
    .height('30%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin(5)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.pageStack.pushPathByName(routeName, null);
    })
  }

  build() {
    Navigation(this.pageStack){
      Column() {
        Text('Your Activities')
          .fontColor(Color.Black)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 10 })

        Column() {
          Row({ space: 10 }) {
            this.buildCard(this.metrics[0], 'Calorie')
            this.buildCard(this.metrics[1], 'HeartRate')
          }
          Row({ space: 10 }) {
            this.buildCard(this.metrics[2], 'StepCount')
            this.buildCard(this.metrics[3], 'BodyTemp')
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
