# Travis 基本使用

官网: https://travis-ci.com

## 下载客户端

仓库地址: https://github.com/travis-ci/travis.rb

## 登录

travis login --github-token YOUR_TOKEN

## 单元测试

### xvfb

如果你选择语言为 nodejs，那么镜像会自带这个工具

## deploy

- https://docs.travis-ci.com/user/deployment
- 如何发布至 Github Release https://docs.travis-ci.com/user/deployment/releases/

### 上传至蒲公英

查看具体步骤，可以点击网址查看官网教程

- https://www.pgyer.com/doc/view/travis_android
- https://www.pgyer.com/doc/view/travis_ios
  - https://github.com/Pgyer/TravisUploadiOSDemo

## cocoapods

部分cordova 插件依赖于这个库，需要确保这个库已经安装，常见的安装方式有两种，一种是通过 `brew` 进行安装，一种是通过 `gem` 进行安装。

### brew 安装

```bash
brew install cocoapods
pop setup
```

### gem 安装

```bash
mkdir -p $HOME/Software/ruby
export GEM_HOME=$HOME/Software/ruby
gem install cocoapods
gem installed
export PATH=$PATH:$HOME/Software/ruby/bin
pod --version
```

### 报错

- 提示版本不对: 注意镜像是否为 10.1
- 提示安装不成功，无法建立 link: [解决参考](https://stackoverflow.com/questions/37904588/cocoapods-not-installing/48335801#48335801)

### github token 生成

#### 加密 token

`travis encrypt YOUR_GITHUB_RAW_TOKEN -r pengkobe/ionic4-boilerplate --add`

#### 加密文件

只支持打包加密，不支持一个一个文件加密

```bash
# 打包
tar cvf certificates.tar ios_distribution.cer ios_distribution.p12 ionic4_Ad_Hoc_Profile.mobileprovision ionic4travis.jks ios_develop.cer ios_develop.p12 ios_push_distribution.cer ios_push_distribution.p12
# 加密
travis encrypt-file certificates.tar -r pengkobe/ionic4-boilerplate
```

## 运行报错

- 无法成功安装 `oracle-java8-installer`,android 语言自带有 JDK，实际上无需安装
- error installing travis:ERROR: Failed to build gem native extension. **事实上在 windows 上生成的 enc 文件都是会报错的**
- 加密多个文件时，必须得打包成一个文件进行加密，否则会报错！
- 构建 IOS 环境时，老是提示证书找不到，我后来直接使用 [fastlane](https://fastlane.tools/) 去管理了，硬是需要使用 travis 构建，可以参考这个 [travis-ci-fails-to-build-with-a-code-signing-error](https://stackoverflow.com/questions/27671854/travis-ci-fails-to-build-with-a-code-signing-error?rq=1) 和看看这个 ISSUE[Code Sign error: No code signing identities found](https://github.com/travis-ci/travis-ci/issues/3072)
- 提示: `No output has been received in the last 10m0s` , 属于 `Mac: macOS Sierra (10.12) Code Signing Error` , 参见 Travis 官方文档对应的 [解决办法](https://docs.travis-ci.com/user/common-build-problems/#Build-times-out-because-no-output-was-received)

## 参考

* https://github.com/samueltbrown/ionic-continuous-delivery-blog ,这篇文章年代有点久远，还是需要做一些修正才行
  - 文中对 XCode7+ iOS9 中的 App Transport Security 处理脚本其实不再需要了，默认就是设置为 true 了
  - update_xcconfig 那段也不需要了，高版本 Xcode 也已经默认移除了相关配置
* [为iOS建立Travis CI（史上最全版）](https://blog.csdn.net/qq_30817073/article/details/51719473) ,事实上还是比较全的
