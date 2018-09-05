# NodeMCU_Node

nodemcu collect sensor data and send to server with mqtt

This repertory is a part of a certain iot project with lora which collect and handle some sensor data about fire-fighting. Other parts and more details of project might be update later.

This project modules is that nodemcu get the temperature and humidity from DHT11 and send data to server with mqtt. but due to test it only generates random data

#### Usage

suppose you are konw about NodeMCU. get more information from [NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/)

change some field in config.lua according to your certain configuration.

#### Modules Require

- wifi
- mqtt
- net
- http

#### Data Format

- Serial numbers
- Battery voltage
- Signal Strength
- Device Location
- Message Timestamp
- Integral part of temperature
- Decimal of temperature

add a comma between each variable.
The last string is formatted as "%s,%4.2f,%d,%s,%s,%d,%d"

#### Results

---

这个仓库作为物联网项目的一部分，具体功能是使用NodeMCU采集传感器数据并使用MQTT协议发送给服务器

#### 使用

使用需了解NodeMCU的烧录和编程操作  详见[文档](https://nodemcu.readthedocs.io/en/master/)

按照你的具体环境修改config.lua的相关字段

#### 模块依赖

- wifi
- mqtt
- net
- http

#### 数据格式

- 设备序列号
- 电池电压
- 信号强度
- 设备位置
- 发送时间
- 温度整数部分
- 温度小数部分

每个变量之间添加逗号并且按照 "%s,%4.2f,%d,%s,%s,%d,%d" 对字符串进行格式化

#### 效果

![](https://i.loli.net/2018/09/05/5b8fa7c8c8961.jpg)




