# BannerView

flutter的轮播图控件

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).

###属性
* data 传入list<*>
* onBannerClickListener(index,itemData) 点击事件
* delayTime 秒 延迟多少秒进入下一页
* scrollTime 毫秒 滑动至下页需要秒数
* height 高度
* buildShowView(index,itemData) 返回一个用于展示的widget

###例子
```
    new BannerView(
          data: ['a', 'b', 'c'],
          buildShowView: (index,data) {
            print(data);
            return new CustomWidget(text: data);
          },
          onBannerClickListener: (index,data){
            print(index);
          },
        ),
```