interface Metric {
  title: string
  value: number
  unit: string
  icon: Resource
  goal: number
  lastUpdate: string
}

@Component
export struct Calorie {
  @State calorie: Metric = {
    title: 'Calories',
    value: 786,
    unit: 'kcal',
    icon: $r('app.media.walking'),
    goal: 2000,
    lastUpdate: '10:45 AM'
  }

  @Consume('NavPathStack') pageStack: NavPathStack;

  build() {
    NavDestination(){
      Column() {
        Text(this.calorie.title)
          .fontColor(Color.Black)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 10 })

        Column() {
          Image(this.calorie.icon)
            .width(50)
            .height(50)
            .objectFit(ImageFit.Contain)
            .margin({ bottom: 5 })

          Row() {
            Text(this.calorie.value.toString())
              .fontSize(18)
              .fontColor(Color.Black)
              .textAlign(TextAlign.Center)
              .margin({ right: 2 })
            Text(this.calorie.unit)
              .fontSize(12)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
          }
          .margin({ bottom: 6 })

          Text(`${((this.calorie.value / this.calorie.goal) * 100).toFixed(1)}% of ${this.calorie.goal} ${this.calorie.unit} goal`)
            .fontSize(10)
            .fontColor(Color.Gray)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 4 })

          Text(`Last update: ${this.calorie.lastUpdate}`)
            .fontSize(9)
            .fontColor(Color.Gray)
            .textAlign(TextAlign.Center)

          Progress({
            value: this.calorie.value,
            total: this.calorie.goal
          })
            .width(60)
            .height(6)
            .margin({ top: 6 })
            .color(Color.Green)
        }
        .width(90)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .shadow({ radius: 6, color: '#d0d0d0', offsetX: 2, offsetY: 2 })
        .padding(10)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
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
