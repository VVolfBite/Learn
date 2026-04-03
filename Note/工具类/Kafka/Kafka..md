## 消息队列实现原理

![img](../../_images/message-queue/Kafka/mq.png)

- **点对点模式**（一对一，消费者主动拉取数据，消息收到后消息清除） 点对点模型通常是一个基于拉取或者轮询的消息传送模型，这种模型从队列中请求信息， 而不是将消息推送到客户端。这个模型的特点是发送到队列的消息被一个且只有一个接收者接收处理，即使有多个消息监听者也是如此。 
- **发布/订阅模式**（一对多，数据生产后，推送给所有订阅者） 发布订阅模型则是一个基于推送的消息传送模型。发布订阅模型可以有多种不同的订阅者，临时订阅者只在主动监听主题时才接收消息，而持久订阅者则监听主题的所有消息，即使当前订阅者不可用，处于离线状态。    

------

## 为什么需要消息队列

1. **解耦**： 允许你独立的扩展或修改两边的处理过程，只要确保它们遵守同样的接口约束。
2. **冗余**：消息队列把数据进行持久化直到它们已经被完全处理，通过这一方式规避了数据丢失风 险。许多消息队列所采用的"插入-获取-删除"范式中，在把一个消息从队列中删除之前，需 要你的处理系统明确的指出该消息已经被处理完毕，从而确保你的数据被安全的保存直到你使用完毕。 
3. **扩展性**： 因为消息队列解耦了你的处理过程，所以增大消息入队和处理的频率是很容易的，只要 另外增加处理过程即可。 
4. **灵活性 & 峰值处理能力**： 在访问量剧增的情况下，应用仍然需要继续发挥作用，但是这样的突发流量并不常见。 如果为以能处理这类峰值访问为标准来投入资源随时待命无疑是巨大的浪费。使用消息队列 能够使关键组件顶住突发的访问压力，而不会因为突发的超负荷的请求而完全崩溃。 
5. **可恢复性**： 系统的一部分组件失效时，不会影响到整个系统。消息队列降低了进程间的耦合度，所 以即使一个处理消息的进程挂掉，加入队列中的消息仍然可以在系统恢复后被处理。
6. **顺序保证**： 在大多使用场景下，数据处理的顺序都很重要。大部分消息队列本来就是排序的，并且 能保证数据会按照特定的顺序来处理。（Kafka 保证一个 Partition 内的消息的有序性）
7. **缓冲**： 有助于控制和优化数据流经过系统的速度， 解决生产消息和消费消息的处理速度不一致 的情况。 
8. **异步通信**： 很多时候，用户不想也不需要立即处理消息。消息队列提供了异步处理机制，允许用户把一个消息放入队列，但并不立即处理它。想向队列中放入多少消息就放多少，然后在需要 的时候再去处理它们    

------

## 泥豪，Kafka

Kafka是一个分布式的流处理平台。是支持分区（partition）、多副本（replica）的分布式消息系统，它的最大的特性就是可以实时的处理大量数据以满足各种需求场景：比如基于hadoop的批处理系统、低延迟的实时系统、storm/Spark流式处理引擎，web/nginx日志、访问日志，消息服务等等 

#### 有三个关键能力

- 它可以让你发布和订阅记录流。在这方面，它类似于一个消息队列或企业消息系统
- 它可以让你持久化收到的记录流，从而具有容错能力。
- 它可以让你处理收到的记录流。

#### 它应用于2大类应用

- 构建实时的流数据管道，可靠地获取系统和应用程序之间的数据。
- 构建实时流的应用程序，对数据流进行转换或反应。

### 概念

- kafka作为一个集群运行在一个或多个服务器上。
- kafka集群存储的消息是以topic为类别记录的。
- 每个消息是由一个key，一个value和时间戳构成。

#### Kafka有四个核心API：

- [生产者 API](http://kafka.apache.org/documentation.html#producerapi) 允许应用程序发布记录流至一个或多个Kafka的话题(Topics)。

- [消费者API](http://kafka.apache.org/documentation.html#consumerapi)允许应用程序订阅一个或多个主题，并处理这些主题接收到的记录流。

- [Streams API](http://kafka.apache.org/documentation/streams)允许应用程序充当流处理器（stream processor），从一个或多个主题获取输入流，并生产一个输出流至一个或多个的主题，能够有效地变换输入流为输出流。

- [Connector API](http://kafka.apache.org/documentation.html#connect)允许构建和运行可重用的生产者或消费者，能够把 Kafka主题连接到现有的应用程序或数据系统。例如，一个连接到关系数据库的连接器(connector)可能会获取每个表的变化。

  ![img](../../_images/message-queue/Kafka/kafka-apis.png)

Kafka的客户端和服务器之间的通信是靠一个简单的，高性能的，与语言无关的[TCP协议](https://kafka.apache.org/protocol.html)完成的。这个协议有不同的版本，并保持向后兼容旧版本。Kafka不光提供了一个Java客户端，还有[许多语言](https://cwiki.apache.org/confluence/display/KAFKA/Clients)版本的客户端。

#### 主题和日志

主题是一种分类或发布的一系列记录的名义上的名字。Kafka的主题始终是支持多用户订阅的; 也就是说，一个主题可以有零个，一个或多个消费者订阅写入的数据。

对于每一个主题，Kafka集群保持一个分区日志文件，看下图：

![img](../../_images/message-queue/Kafka/log_anatomy.png)

**每个分区是一个有序的，不可变的消息序列**，新的消息不断追加到这个有组织的有保证的日志上。分区会给每个消息记录分配一个**顺序ID号 – 偏移量**， 能够唯一地标识该分区中的每个记录。**kafka不能保证全局有序，只能保证分区内有序** 。

Kafka集群保留所有发布的记录，不管这个记录有没有被消费过，Kafka提供可配置的保留策略去删除旧数据(还有一种策略根据分区大小删除数据)。例如，如果将保留策略设置为两天，在记录公布后两天，它可用于消费，之后它将被丢弃以腾出空间。Kafka的性能跟存储的数据量的大小无关， 所以将数据存储很长一段时间是没有问题的。

![img](../../_images/message-queue/Kafka/log_consumer.png)

事实上，保留在每个消费者元数据中的最基础的数据就是消费者正在处理的当前记录的**偏移量(offset)或位置(position)**。这种偏移是由消费者控制：通常偏移会随着消费者读取记录线性前进，但事实上，因为其位置是由消费者进行控制，消费者可以在任何它喜欢的位置读取记录。例如，消费者可以恢复到旧的偏移量对过去的数据再加工或者直接跳到最新的记录，并消费从“现在”开始的新的记录。

这些功能的结合意味着，实现Kafka的消费者的代价都是很小的，他们可以增加或者减少而不会对集群或其他消费者有太大影响。例如，你可以使用我们的命令行工具去追随任何主题，而且不会改变任何现有的消费者消费的记录。

数据日志的分区，一举数得。首先，它们允许数据能够扩展到更多的服务器上去。每个单独的分区的大小受到承载它的服务器的限制，但一个话题可能有很多分区，以便它能够支持海量的的数据。其次，更重要的意义是分区是进行并行处理的基础单元。

#### 分布式

日志的分区会跨服务器的分布在Kafka集群中，每个服务器会共享分区进行数据请求的处理。**每个分区可以配置一定数量的副本分区提供容错能力。**

**每个分区都有一个服务器充当“leader”和零个或多个服务器充当“followers”**。 leader处理所有的读取和写入分区的请求，而followers被动的从领导者拷贝数据。如果leader失败了，followers之一将自动成为新的领导者。每个服务器可能充当一些分区的leader和其他分区的follower，这样的负载就会在集群内很好的均衡分配。

#### 生产者

生产者发布数据到他们所选择的主题。生产者负责选择把记录分配到主题中的哪个分区。这可以使用轮询算法( round-robin)进行简单地平衡负载，也可以根据一些更复杂的语义分区算法（比如基于记录一些键值）来完成。

#### 消费者

消费者以消费群（**consumer group** ）的名称来标识自己，每个发布到主题的消息都会发送给订阅了这个主题的消费群里面的一个消费者的一个实例。消费者的实例可以在单独的进程或单独的机器上。

如果所有的消费者实例都属于相同的消费群，那么记录将有效地被均衡到每个消费者实例。

如果所有的消费者实例有不同的消费群，那么每个消息将被广播到所有的消费者进程。

这是kafka用来实现一个topic消息的广播（发给所有的consumer） 和单播（发给任意一个 consumer）的手段。一个 topic 可以有多个 CG。 topic 的消息会复制 （不是真的复制，是概念上的）到所有的 CG，但每个 partion 只会把消息发给该 CG 中的一 个 consumer。如果需要实现广播，只要每个 consumer 有一个独立的 CG 就可以了。要实现 单播只要所有的 consumer 在同一个 CG。用 CG 还可以将 consumer 进行自由的分组而不需 要多次发送消息到不同的 topic； 

![img](../../_images/message-queue/Kafka/sumer-groups.png)

两个服务器的Kafka集群具有四个分区（P0-P3）和两个消费群。A消费群有两个消费者，B群有四个。

更常见的是，我们会发现主题有少量的消费群，每一个都是“逻辑上的订阅者”。每组都是由很多消费者实例组成，从而实现可扩展性和容错性。这只不过是发布 – 订阅模式的再现，区别是这里的订阅者是一组消费者而不是一个单一的进程的消费者。

**Kafka消费群的实现方式是通过分割日志的分区，分给每个Consumer实例，使每个实例在任何时间点的都可以“公平分享”独占的分区**。维持消费群中的成员关系的这个过程是通过Kafka动态协议处理。如果新的实例加入该组，他将接管该组的其他成员的一些分区; 如果一个实例死亡，其分区将被分配到剩余的实例。

Kafka只保证一个分区内的消息有序，不能保证一个主题的不同分区之间的消息有序。分区的消息有序与依靠主键进行数据分区的能力相结合足以满足大多数应用的要求。但是，如果你想要保证所有的消息都绝对有序可以只为一个主题分配一个分区，虽然这将意味着每个消费群同时只能有一个消费进程在消费。

#### 保证

Kafka提供了以下一些高级别的保证：	

- 由生产者发送到一个特定的主题分区的消息将被以他们被发送的顺序来追加。也就是说，如果一个消息M1和消息M2都来自同一个生产者，M1先发，那么M1将有一个低于M2的偏移，会更早在日志中出现。
- 消费者看到的记录排序就是记录被存储在日志中的顺序。
- 对于副本因子N的主题，我们将承受最多N-1次服务器故障切换而不会损失任何的已经保存的记录。

### Kafka架构图

![img](../../_images/message-queue/Kafka/kakfa-principle.png)

- Broker ：一台 kafka 服务器就是一个 broker。一个集群由多个 broker 组成。一个 broker 可以容纳多个 topic； 
- Partition：为了实现扩展性，一个非常大的 topic 可以分布到多个 broker（即服务器）上， 一个 topic 可以分为多个 partition，每个 partition 是一个有序的队列。 partition 中的每条消息 都会被分配一个有序的 id（ offset）。 kafka 只保证按一个 partition 中的顺序将消息发给 consumer，不保证一个 topic 的整体（多个 partition 间）的顺序； 
- Offset： kafka 的存储文件都是按照 offset.kafka 来命名，用 offset 做名字的好处是方便查 找。例如你想找位于 2049 的位置，只要找到 2048.kafka 的文件即可。当然 the first offset 就 是 00000000000.kafka。

## Kafka 工作流程分析和存储机制

![img](../../_images/message-queue/Kafka/kafka-workflow.jpg)

**Kafka中消息是以topic进行分类的**，生产者生产消息，消费者消费消息，都是面向topic的。

topic是逻辑上的概念，二patition是物理上的概念，每个patition对应一个log文件，而log文件中存储的就是producer生产的数据，patition生产的数据会被不断的添加到log文件的末端，且每条数据都有自己的offset。消费组中的每个消费者，都是实时记录自己消费到哪个offset，以便出错恢复，从上次的位置继续消费。

![img](../../_images/message-queue/Kafka/kafka-partition.jpg)

由于生产者生产的消息会不断追加到log文件末尾，为防止log文件过大导致数据定位效率低下，Kafka采取了**分片**和**索引**机制，将每个partition分为多个segment。每个segment对应两个文件——“.index”文件和“.log”文件。这些文件位于一个文件夹下，该文件夹的命名规则为：topic名称+分区序号。例如，first这个topic有三个分区，则其对应的文件夹为first-0,first-1,first-2。

```shell
00000000000000000000.index
00000000000000000000.log
00000000000000170410.index
00000000000000170410.log
00000000000000239430.index
00000000000000239430.log
```

index和log文件以当前segment的第一条消息的offset命名。下图为index文件和log文件的结构示意图。 

![img](../../_images/message-queue/Kafka/kafka-segement.jpg)

### Kafka 生产过程

#### 写入流程

producer 写入消息流程如下： 

![img](../../_images/message-queue/Kafka/kafka-write-flow.png)

1. producer 先获取该 partition 的 leader 元数据
2. producer 将消息发送给该 leader 
3. leader 将消息写入本地 log 
4. followers 从 leader pull 消息，写入本地 log 后向 leader 发送 ACK    
5. leader 收到所有 ISR 中的 replication 的 ACK 后，增加 HW（high watermark，最后 commit 的 offset）并向 producer 发送 ACK 

#### 写入方式

	producer 采用推（push） 模式将消息发布到 broker，每条消息都被追加（append） 到分区（patition） 中，属于顺序写磁盘（顺序写磁盘效率比随机写内存要高，保障 kafka 吞吐率）。

#### 分区（Partition）

	消息发送时都被发送到一个 topic，其本质就是一个目录，而 topic 是由一些 Partition Logs(分区日志)组成

- 分区的原因 

1. **方便在集群中扩展**，每个 Partition 可以通过调整以适应它所在的机器，而一个 topic 又可以有多个 Partition 组成，因此整个集群就可以适应任意大小的数据了；

2. **可以提高并发**，因为可以以 Partition 为单位读写了。 

- 分区的原则 

1. 指定了 patition，则直接使用； 

2. 未指定 patition 但指定 key，通过对 key 的 value 进行 hash 出一个 patition； 

3. patition 和 key 都未指定，使用轮询选出一个 patition。    

#### 副本（Replication）

 	同 一 个 partition 可 能 会 有 多 个 replication （ 对 应 server.properties 配 置 中 的 default.replication.factor=N）。没有 replication 的情况下，一旦 broker 宕机，其上所有 patition 的数据都不可被消费，同时 producer 也不能再将数据存于其上的 patition。引入 replication 之后，同一个 partition 可能会有多个 replication，而这时需要在这些 replication 之间选出一 个 leader， producer 和 consumer 只与这个 leader 交互，其它 replication 作为 follower 从 leader 中复制数据    

#### 数据可靠性保证

	为保证producer发送的数据，能可靠的发送到指定的topic，topic的每个partition收到producer数据后，都需要向producer发送ack（acknowledgement确认收到），如果producer收到ack，就会进行下一轮的发送，否则重新发送数据。

![img](../../_images/message-queue/Kafka/kafka-ack-slg.png)

##### 副本数据同步策略

| 方案                        | 优点                                               | 缺点                                                |
| --------------------------- | -------------------------------------------------- | --------------------------------------------------- |
| 半数以上完成同步，就发送ack | 延迟低                                             | 选举新的leader时，容忍n台借点的故障，需要2n+1个副本 |
| 全部完成同步，才发送ack     | 选举新的leader时，容忍n台借点的故障，需要n+1个副本 | 延迟高                                              |

Kafka选择了第二种方案，原因如下：

- 同样为了容忍n台节点的故障，第一种方案需要的副本数相对较多，而Kafka的每个分区都有大量的数据，第一种方案会造成大量的数据冗余；
- 虽然第二种方案的网络延迟会比较高，但网络延迟对Kafka的影响较小。

##### ISR

	采用第二种方案之后，设想一下情景：leader收到数据，所有follower都开始同步数据，但有一个follower挂了，迟迟不能与leader保持同步，那leader就要一直等下去，直到它完成同步，才能发送ack，这个问题怎么解决呢？
	
	leader维护了一个动态的in-sync replica set(ISR),意为和leader保持同步的follower集合。当ISR中的follower完成数据的同步之后，leader就会给follower发送ack。如果follower长时间未向leader同步数据，则该follower将会被踢出ISR，该时间阈值由replica.lag.time.max.ms参数设定。leader发生故障之后，就会从ISR中选举新的leader。（之前还有另一个参数，0.9 版本之后 replica.lag.max.messages 参数被移除了）

##### ack应答机制

	对于某些不太重要的数据，对数据的可靠性要求不是很高，能够容忍数据的少量丢失，所以没必要等ISR中的follower全部接收成功。
	
	所以Kafka为用户提供了**三种可靠性级别**，用户根据对可靠性和延迟的要求进行权衡，选择以下的配置。

**acks参数配置：**

- **acks:**

  	0：producer不等待broker的ack，这一操作提供了一个最低的延迟，broker一接收到还没有写入磁盘就已经返回，当broker故障时有可能**丢失数据**；
  	
  	1：producer不等待broker的ack，这一操作提供了一个最低的延迟，broker一接收到还没有写入磁盘就已经返回，当broker故障时有可能**丢失数据**（下图为acks=1数据丢失案例）；

![img](../../_images/message-queue/Kafka/kafka-ack=1.png)

	-1（all）：producer等待broker的ack，partition的leader和follower全部落盘成功后才返回ack。但是	如果在follower同步完成后，broker发送ack之前，leader发生故障，那么就会造成**数据重复**。（下图为acks=1数据重复案例）

![img](../../_images/message-queue/Kafka/kafka-ack=-1.png)

##### 故障处理

![img](../../_images/message-queue/Kafka/kafka-leo.png)

- **LEO: 指的是每个副本最大的offset;**
- **HW：指的是消费者能见到的最大的offset，ISR队列中最小的LEO;**

（1）**followew故障**

	follower发生故障后会被临时踢出ISR,待该follower恢复后，follower会读取本地磁盘记录的上次的HW，并将log文件高于HW的部分截取掉，从HW开始向leader进行同步。等**该followew的LEO大于该Partition的HW**，即follower追上leader之后，就可以重新加入ISR了。

（2） **leader故障**

	leader发生故障之后，会从ISR中选出一个新的leader，之后，为保证多个副本之间的数据一致性，其余的follower会先将各自的log文件高于HW的部分截掉，然后从新的leader同步数据。
	
	注意：这**只能保证副本之间的数据一致性，并不能保证数据不丢失或者不重复**。

#### Exactly Once语义

	将服务器的ACK级别设置为-1，可以保证Producer到Server之间不会丢失数据，即At Least Once语义。相对的，将服务器ACK级别设置为0，可以保证生产者每条消息只会被发送一次，即At Most Once语义。
	
	At Least Once可以保证数据不丢失，但是不能保证数据不重复。相对的，At Least Once可以保证数据不重复，但是不能保证数据不丢失。但是，对于一些非常重要的信息，比如说交易数据，下游数据消费者要求数据既不重复也不丢失，即Exactly Once语义。在0.11版本以前的Kafka，对此是无能为力的，智能保证数据不丢失，再在下游消费者对数据做全局去重。对于多个下游应用的情况，每个都需要单独做全局去重，这就对性能造成了很大的影响。
	
	0.11版本的Kafka，引入了一项重大特性：幂等性。所谓的幂等性就是指	Producer不论向Server发送多少次重复数据。Server端都会只持久化一条，幂等性结合At Least Once语义，就构成了Kafka的Exactily Once语义，即： **<u>At Least Once + 幂等性 = Exactly Once</u>**
	
	要启用幂等性，只需要将Producer的参数中enable.idompotence设置为true即可。Kafka的幂等性实现其实就是将原来下游需要做的去重放在了数据上游。开启幂等性的Producer在初始化的时候会被分配一个PID，发往同一Partition的消息会附带Sequence Number。而Broker端会对<PID,Partition,SeqNumber>做缓存，当具有相同主键的消息提交时，Broker只会持久化一条。
	
	但是PID重启就会变化，同时不同的Partition也具有不同主键，所以幂等性无法保证跨分区会话的Exactly Once。

### Broker 保存消息

#### 存储方式

	物理上把 topic 分成一个或多个 patition（对应 server.properties 中的 num.partitions=3 配 置），每个 patition 物理上对应一个文件夹（该文件夹存储该 patition 的所有消息和索引文 件）。    

#### 存储策略

	无论消息是否被消费， kafka 都会保留所有消息。有两种策略可以删除旧数据： 

1. 基于时间： log.retention.hours=168 

2. 基于大小： log.retention.bytes=1073741824 需要注意的是，因为 Kafka 读取特定消息的时间复杂度为 O(1)，即与文件大小无关， 所以这里删除过期文件与提高 Kafka 性能无关。

### Kafka 消费过程

#### 消费者组

![img](../../_images/message-queue/Kafka/kafka-consume-group.png)

	消费者是以 consumer group 消费者组的方式工作，由一个或者多个消费者组成一个组， 共同消费一个 topic。每个分区在同一时间只能由 group 中的一个消费者读取，但是多个 group 可以同时消费这个 partition。在图中，有一个由三个消费者组成的 group，有一个消费者读 取主题中的两个分区，另外两个分别读取一个分区。某个消费者读取某个分区，也可以叫做 某个消费者是某个分区的拥有者。
	
	在这种情况下，消费者可以通过水平扩展的方式同时读取大量的消息。另外，如果一个 消费者失败了，那么其他的 group 成员会自动负载均衡读取之前失败的消费者读取的分区。    

#### 消费方式

**consumer 采用 pull（拉） 模式从 broker 中读取数据。** 

	push（推）模式很难适应消费速率不同的消费者，因为消息发送速率是由 broker 决定的。 它的目标是尽可能以最快速度传递消息，但是这样很容易造成 consumer 来不及处理消息， 典型的表现就是拒绝服务以及网络拥塞。而 pull 模式则可以根据 consumer 的消费能力以适当的速率消费消息。 
	
	对于 Kafka 而言， pull 模式更合适，它可简化 broker 的设计， consumer 可自主控制消费消息的速率，同时 consumer 可以自己控制消费方式——即可批量消费也可逐条消费，同时 还能选择不同的提交方式从而实现不同的传输语义。 
	
	pull 模式不足之处是，如果 kafka 没有数据，消费者可能会陷入循环中，一直等待数据到达，一直返回空数据。为了避免这种情况，我们在我们的拉请求中有参数，允许消费者请求在等待数据到达 的“长轮询”中进行阻塞（并且可选地等待到给定的字节数，以确保大的传输大小）。    

#### 分区分配策略

	一个consumer group中有多个consumer，一个topic有多个partition，所以必然会涉及到partition的分配问题，即确定哪个partition由哪个consumer来消费。
	
	Kafka有两种分配策略，一是RoundRobin，一是Range。

#### offset的维护

	由于consumer在消费过程中可能会出现断电宕机等故障，consumer恢复后，需要从故障前的位置继续消费，所以consumer需要实时记录自己消费到了哪个offset，以便故障恢复后继续消费。
	
	当前Kafka会将消费位点保存在Kafka内部主题 **__consumer_offsets** 中。自动提交和手动提交，本质上都是在维护这个位点信息。一般情况下，只需要关注：

- 是否开启自动提交
- 什么时候提交offset
- 发生异常时是否可能重复消费

在实际开发中，自动提交适合简单场景；对数据一致性要求较高时，通常使用手动提交offset。

### Kafka高效读写数据的原因

#### 顺序写磁盘

	Kafka的producer生产数据，要写入到log文件中，写的过程是一直追加到文件末端，为顺序写。官网有数据表明，同样的磁盘，顺序写能到到600M/s，而随机写只有100k/s。这与磁盘的机械机构有关，顺序写之所以快，是因为其省去了大量磁头寻址的时间 。

## Kafka API（Java中的Kafka使用）

### 导入 pom 依赖

```xml
<dependency>
    <groupId>org.apache.kafka</groupId>
    <artifactId>kafka-clients</artifactId>
    <version>请按项目实际版本选择</version>
</dependency>
```

### 创建生产者

	Kafka的Producer发送消息采用的是**异步发送**的方式。在消息发送过程中，涉及到了两个线程：**main线程和Sender线程**，以及一个线程共享变量：**RecordAccumulator**。main线程将消息发送给RecordAccumulator，Sender线程不断从RecordAccumulator中拉取消息发送到Kafka broker。

![img](../../_images/message-queue/Kafka/kafka-producer-thread.png)

相关参数：	

- **batch.size**：只有数据积累到batch.size之后，sender才会发送数据。
- **linger.ms**：如果数据迟迟未达到batch.size，sender等待linger.time之后就会发送数据。

#### 异步发送API

```java
package priv.learn.producer;
import java.util.Properties;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class CustomerProducer {
    public static void main(String[] args) {
        Properties properties = new Properties();
        // Kafka 服务端的主机名和端口号
        properties.put("bootstrap.servers", "localhost:9092");
        // 等待所有副本节点的应答
        properties.put("acks", "all");
        // 消息发送最大尝试次数
        properties.put("retries", 0);
        // 一批消息处理大小
        properties.put("batch.size", 16384);
        // 请求延时
        properties.put("linger.ms", 1);
        // 发送缓存区内存大小
        properties.put("buffer.memory", 33554432);
        // key 序列化
        properties.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        // value 序列化
        properties.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        Producer<String, String> producer = new KafkaProducer<String, String>(properties);
        for (int i = 0; i < 50; i++) {
            producer.send(new ProducerRecord<String, String>("learn-java-kafka",
                    Integer.toString(i), "hello world-" + i));
        }
        producer.close();
    }
}
```

#### 异步发送，带回调函数

```java
package priv.learn.producer;

import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import java.util.Properties;

/**
- @date: 2019/9/9 16:11
- @description: 创建生产者带回调函数（新 API）
  */
  public class CallBackProducer {

  public static void main(String[] args) {
      Properties props = new Properties();
      props.put("bootstrap.servers", "localhost:9092");
      // 等待所有副本节点的应答
      props.put("acks", "all");
      // 消息发送最大尝试次数
      props.put("retries", 0);
      // 一批消息处理大小
      props.put("batch.size", 16384);
      // 增加服务端请求延时
      props.put("linger.ms", 1);
      // 发送缓存区内存大小
      props.put("buffer.memory", 33554432);
      // key 序列化
      props.put("key.serializer",
              "org.apache.kafka.common.serialization.StringSerializer");
      // value 序列化
      props.put("value.serializer",
              "org.apache.kafka.common.serialization.StringSerializer");
      KafkaProducer<String, String> kafkaProducer = new KafkaProducer<>(props);
      for (int i = 0; i < 50; i++) {
          kafkaProducer.send(new ProducerRecord<String, String>("learn-java-kafka", "hello"
                  + i), new Callback() {
              @Override
              public void onCompletion(RecordMetadata metadata, Exception
                      exception) {
                  if (metadata != null) {
                      System.err.println(metadata.partition() + "---" +
                              metadata.offset());
                  }
              }
          });
      }
      kafkaProducer.close();
  }
  }
```

#### 同步发送

通过 producer.send（record)返回Future对象，通过调用Future.get()进行无限等待结果返回。 

```java
producer.send(record).get()
```

### 创建消费者

Kafka消费者最常见的两种使用方式如下：自动提交offset与手动提交offset。

#### 自动提交offset

- 优点 

  - 写法简单
  - 不需要自行管理 offset
  - 消费者重启后可以从上一次提交的位置继续消费

- 缺点 

  - 不方便精细控制提交时机
  - 对数据一致性要求较高的场景不够灵活

  ```java
  package priv.learn.consume;
  import org.apache.kafka.clients.consumer.ConsumerRecord;
  import org.apache.kafka.clients.consumer.ConsumerRecords;
  import org.apache.kafka.clients.consumer.KafkaConsumer;
  import java.util.Arrays;
  import java.util.Properties;
  
  /**
   * @date: 2019/9/9 16:58
   * @description: 高级 API:官方提供案例（自动维护消费情况）（新 API）
   */
  public class CustomNewConsumer {
  
      public static void main(String[] args) {
          Properties props = new Properties();
          // 定义 kakfa 服务的地址，不需要将所有 broker 指定上
          props.put("bootstrap.servers", "localhost:9092");
          // 制定 consumer group
          props.put("group.id", "test");
          // 是否自动确认 offset
          props.put("enable.auto.commit", "true");
          // 自动确认 offset 的时间间隔
          props.put("auto.commit.interval.ms", "1000");
          // key 的序列化类
          props.put("key.deserializer",
                  "org.apache.kafka.common.serialization.StringDeserializer");
          // value 的序列化类
          props.put("value.deserializer",
                  "org.apache.kafka.common.serialization.StringDeserializer");
          // 定义 consumer
          KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
          // 消费者订阅的 topic, 可同时订阅多个
          consumer.subscribe(Arrays.asList("first", "second", "third","learn-java-kafka"));
          while (true) {
              // 读取数据，读取超时时间为 100ms
              ConsumerRecords<String, String> records = consumer.poll(100);
              for (ConsumerRecord<String, String> record : records) {
                  System.out.printf("offset = %d, key = %s, value = %s%n",
                          record.offset(), record.key(), record.value());
              }
          }
      }
  }
  ```

  **结果：**

  ![img](../../_images/message-queue/Kafka/kakfa-java-demo.png)

  

#### 手动提交offset

- 优点    

  - **能够让开发者自己控制 offset，想从哪里读取就从哪里读取。** 
  - 可以自行决定处理完成后再提交 offset
  - 更适合对重复消费、漏消费更敏感的场景

- 缺点

  - 使用起来更复杂
  - 需要自己处理提交时机和异常场景

- 手动提交offset的方法有两种，分别是commitSync(同步提交)和commitAsync(异步提交)。两者的相同点是，都会将本次poll的一批数据最高的偏移量提交；不同点是，commitSync阻塞当前线程，一直到提交成功，并且会自动失败重试（由不可控因素导致，也会出现提交失败）；而commitAsync则没有失败重试机制，故有可能提交失败。

##### 同步提交offset

```java
package priv.learn.consume;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import java.util.Arrays;
import java.util.Properties;
/**
 * @date: 2019/10/10 16:33
 * @description: 同步手动提交offset
 */
public class CommitSyncCounsumer {

    public static void main(String[] args) {
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put(ConsumerConfig.GROUP_ID_CONFIG, "test");

        //1. 关闭自动提交offset
        props.put("enable.auto.commit", "false");
        props.put("key.deserializer",
                "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer",
                "org.apache.kafka.common.serialization.StringDeserializer");
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Arrays.asList("first", "second", "third","learn-java-kafka"));
        while (true) {
            ConsumerRecords<String, String> records = consumer.poll(100);
            for (ConsumerRecord<String, String> record : records) {
                System.out.printf("offset = %d, key = %s, value = %s%n",
                        record.offset(), record.key(), record.value());
            }
            //2. 需要自己手动提交
            consumer.commitSync();
        }
    }
}
```

##### 异步提交offset

```java
while (true) {
    ConsumerRecords<String, String> records = consumer.poll(100);
    for (ConsumerRecord<String, String> record : records) {
        System.out.printf("offset = %d, key = %s, value = %s%n", record.offset(), record.key(), record.value());
    }
    consumer.commitAsync(new OffsetCommitCallback() {
        @Override
        public void onComplete(Map<TopicPartition, OffsetAndMetadata> map, Exception e) {
            if(e != null){
                System.out.println("commit failed"+map);
            }
        }
    });
}
```

还可以用官方提供的例子跑一下：<https://github.com/apache/kafka/tree/trunk/examples> 

------

## Kafka producer 拦截器(interceptor)

### 拦截器原理

	Producer 拦截器(interceptor)是在 Kafka 0.10 版本被引入的，主要用于实现 clients 端的定制化控制逻辑。 	对于 producer 而言， interceptor 使得用户在消息发送前以及 producer 回调逻辑前有机会 对消息做一些定制化需求，比如**修改消息**等。同时， producer 允许用户指定多个 interceptor 按序作用于同一条消息从而形成一个拦截链(interceptor chain)。 Intercetpor 的实现接口是 **org.apache.kafka.clients.producer.ProducerInterceptor**，其定义的方法包括： 

1. configure(configs) ：获取配置信息和初始化数据时调用。 

2. onSend(ProducerRecord)： 该方法封装进 KafkaProducer.send 方法中，即它运行在用户主线程中。 Producer 确保在 消息被序列化以及计算分区前调用该方法。 用户可以在该方法中对消息做任何操作，但最好 保证不要修改消息所属的 topic 和分区， 否则会影响目标分区的计算 

3. onAcknowledgement(RecordMetadata, Exception)： 该方法会在消息被应答或消息发送失败时调用，并且通常都是在 producer 回调逻辑触 发之前。 onAcknowledgement 运行在 producer 的 IO 线程中，因此不要在该方法中放入很重 的逻辑，否则会拖慢 producer 的消息发送效率  

4. close： 关闭 interceptor，主要用于执行一些资源清理工作 如前所述， interceptor 可能被运行在多个线程中，因此在具体实现时用户需要自行确保 线程安全。另外倘若指定了多个 interceptor，则 producer 将按照指定顺序调用它们，并仅仅 是捕获每个 interceptor 可能抛出的异常记录到错误日志中而非在向上传递。这在使用过程中 要特别留意。

### 拦截器案例

- 需求： 实现一个简单的双 interceptor 组成的拦截链。第一个 interceptor 会在消息发送前将时间 戳信息加到消息 value 的最前部；第二个 interceptor 会在消息发送后更新成功发送消息数或 失败发送消息数。      

![img](../../_images/message-queue/Kafka/interceptor-demo.png)

- 案例实操 

  - 增加时间戳拦截器 

    ```java
    package priv.learn.interceptor;
    
    import org.apache.kafka.clients.producer.ProducerInterceptor;
    import org.apache.kafka.clients.producer.ProducerRecord;
    import org.apache.kafka.clients.producer.RecordMetadata;
    import java.util.Map;
    
    /**
     * @description: 增加时间拦截器，在发送消息时增加时间
     */
    public class TimeInterceptor implements ProducerInterceptor<String, String> {
        @Override
        public ProducerRecord<String, String> onSend(ProducerRecord<String, String> producerRecord) {
            // 创建一个新的 record，把时间戳写入消息体的最前部
            return new ProducerRecord(producerRecord.topic(), producerRecord.partition(),
                    producerRecord.timestamp(), producerRecord.key(),
                    System.currentTimeMillis() + "," + producerRecord.value().toString());
        }
    
        @Override
        public void onAcknowledgement(RecordMetadata recordMetadata, Exception e) {
        }
    
        @Override
        public void close() {
        }
        @Override
        public void configure(Map<String, ?> map) {
        }
    }
    ```

  

  - 统计发送消息成功和发送失败消息数，并在 producer 关闭时打印这两个计数器 

  ```java
  package priv.learn.interceptor;
  
  import org.apache.kafka.clients.producer.ProducerInterceptor;
  import org.apache.kafka.clients.producer.ProducerRecord;
  import org.apache.kafka.clients.producer.RecordMetadata;
  import java.util.Map;
  
  /**
   * @description:统计发送消息成功和发送失败消息数，并在 producer 关闭时打印这两个计数器
   */
  public class CounterInterceptor  implements ProducerInterceptor<String, String> {
      private int errorCounter = 0;
      private int successCounter = 0;
  
      @Override
      public ProducerRecord<String, String> onSend(ProducerRecord<String, String> producerRecord) {
          return producerRecord;
      }
  
      @Override
      public void onAcknowledgement(RecordMetadata recordMetadata, Exception e) {
          // 统计成功和失败的次数
          if (e == null) {
              successCounter++;
          } else {
              errorCounter++;
          }
      }
  
      @Override
      public void close() {
          // 保存结果
          System.out.println("Successful sent: " + successCounter);
          System.out.println("Failed sent: " + errorCounter);
      }
  
      @Override
      public void configure(Map<String, ?> map) {
      }
  }
  ```

  - 创建生产者

  ```java
  package priv.learn.interceptor;
  
  import org.apache.kafka.clients.producer.KafkaProducer;
  import org.apache.kafka.clients.producer.Producer;
  import org.apache.kafka.clients.producer.ProducerConfig;
  import org.apache.kafka.clients.producer.ProducerRecord;
  import java.util.ArrayList;
  import java.util.List;
  import java.util.Properties;
  
  /**
   * @description: 带拦截器的producer 主程序
   */
  public class InterceptorProducer {
  
      public static void main(String[] args) throws Exception {
          // 1 设置配置信息
          Properties props = new Properties();
          props.put("bootstrap.servers", "localhost:9092");
          props.put("acks", "all");
          props.put("retries", 0);
          props.put("batch.size", 16384);
          props.put("linger.ms", 1);
          props.put("buffer.memory", 33554432);
          props.put("key.serializer",
                  "org.apache.kafka.common.serialization.StringSerializer");
          props.put("value.serializer",
                  "org.apache.kafka.common.serialization.StringSerializer");
          // 2 构建拦截链
          List<String> interceptors = new ArrayList<>();
          interceptors.add("priv.learn.interceptor.TimeInterceptor");
          interceptors.add("priv.learn.interceptor.CounterInterceptor");
          props.put(ProducerConfig.INTERCEPTOR_CLASSES_CONFIG, interceptors);
          String topic = "first";
          Producer<String, String> producer = new KafkaProducer<>(props);
          // 3 发送消息
          for (int i = 0; i < 10; i++) {
              ProducerRecord<String, String> record = new ProducerRecord<>(topic,
                      "message" + i);
              producer.send(record);
          }
          // 4 一定要关闭 producer，这样才会调用 interceptor 的 close 方法
          producer.close();
      }
  }
  ```

------

