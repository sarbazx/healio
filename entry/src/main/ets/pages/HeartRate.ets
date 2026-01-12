interface HeartStatus {
  color: Color
  text: string
}

@Component
export struct HeartRate {
  bpm: number = 88
  lastMeasurementTime: string = '12:40 PM'
  @State status: HeartStatus = { color: Color.Green, text: 'Normal' }
  @Consume('NavPathStack') pageStack: NavPathStack;

  aboutToAppear() {
    this.updateStatus()
  }

  updateStatus() {
    if (this.bpm < 60) {
      this.status = { color: Color.Orange, text: 'Low' }
    } else if (this.bpm <= 100) {
      this.status = { color: Color.Green, text: 'Normal' }
    } else {
      this.status = { color: Color.Red, text: 'High' }
    }
  }

  build() {
    NavDestination(){
      Column() {
        Text('Heart Rate')
          .fontColor(Color.Black)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 5 })

        Image($r('app.media.dot'))
          .width(30)
          .height(30)
          .objectFit(ImageFit.Contain)
          .margin({ bottom: 5 })

        Text('Measuring')
          .fontColor(Color.Black)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 5 })

        Column() {
          Text(this.bpm.toString())
            .fontSize(24)
            .fontColor(this.status.color)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 6 })

          Row() {
            Image($r('app.media.heart'))
              .width(15)
              .height(15)
              .objectFit(ImageFit.Contain)
              .margin({ right: 2 })
            Text('bpm')
              .fontSize(12)
              .fontColor(Color.Black)
              .textAlign(TextAlign.Center)
          }
          .margin({ bottom: 6 })

          Text(this.status.text)
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor(this.status.color)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
            .margin({ bottom: 10 })

          Text(`Last measured: ${this.lastMeasurementTime}`)
            .fontSize(9)
            .fontColor(Color.Gray)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 6 })
        }
        .width(70)
        .height('31%')
        .backgroundColor(Color.White)
        .borderRadius(8)
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
