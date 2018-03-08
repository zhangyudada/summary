# OPNET LEO communication simulation platform
研一负责LEO卫星通信系统链路级仿真平台的搭建，所用软件为OPNET 14.5A（现在已经被[Riverbed](https://www.riverbed.com/cn/products/steelcentral/opnet.html?redirect=opnet) 收购）。  

针对低轨卫星通信系统中通信协议验证的需求， 搭建了一套基于 OPNET 的仿真平台。利用三层建模机制， 自上而下分别建立了该卫星通信系统的网络模型、节点模型和进程模型，并通过有限状态机和 Proto-C 语言对协议进行具体实现。根据卫星轨道参数， 利用 STK 生成轨道文件并导入 OPNET， 卫星节点沿各自轨道运动。 仿真平台采用时隙驱动模式， 将仿真时间划分为连续的时隙， 并为每个时隙分配时隙编号。 在此基础上， 对一种资源分配策略进行了仿真， 并对资源利用率、系统吞吐量、包时延等仿真结果进行了分析， 结果表明该仿真平台具有良好的通用性。 