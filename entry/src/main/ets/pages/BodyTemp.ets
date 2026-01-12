interface Status {
  color: Color
  text: string
}

@Component
export struct BodyTemp {
  lastMeasurement: number = 36.6
  lastMeasurementTime: string = '6:46 PM April 18, 2024'
  @State status: Status = { color: Color.Green, text: 'Normal' }
  @Consume('NavPathStack') pageStack: NavPathStack;

  aboutToAppear() {
    this.updateStatus()
  }

  updateStatus() {
    if (this.lastMeasurement < 35) {
      this.status = { color: Color.Red, text: 'Hypothermia' }
    } else if (this.lastMeasurement < 36) {
      this.status = { color: Color.Orange, text: 'Below Normal' }
    } else if (this.lastMeasurement <= 37.5) {
      this.status = { color: Color.Green, text: 'Normal' }
    } else if (this.lastMeasurement <= 39) {
      this.status = { color: Color.Yellow, text: 'Fever' }
    } else {
      this.status = { color: Color.Red, text: 'High Fever' }
    }
  }

  build() {
    NavDestination(){
      Column() {
        Text('Body Temperature')
          .fontColor(Color.Black)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 12 })

        Column() {
          Image($r('app.media.temp'))
            .width(40)
            .height(40)
            .objectFit(ImageFit.Contain)
            .margin({ bottom: 8 })

          Row({ space: 2 }) {
            Text(this.lastMeasurement.toFixed(1))
              .fontSize(20)
              .fontColor(Color.Black)
            Text('°C')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .margin({ bottom: 6 })

          Text(this.status.text)
            .fontSize(12)
            .fontColor(Color.White)
            .backgroundColor(this.status.color)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
            .margin({ bottom: 6 })
        }
        .width('40%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .shadow({ radius: 6, color: '#d0d0d0', offsetX: 2, offsetY: 2 })
        .padding(12)
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
