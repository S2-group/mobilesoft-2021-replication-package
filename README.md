# The Impact of Instant Messaging on the Energy Consumption of Android Devices 

This repository contains the replication package and dataset of the paper published at MOBILESoft 2021 with the title **The Impact of Instant Messaging on the Energy Consumption of Android Devices**

[![Teaser video about the study](http://img.youtube.com/vi/IfRTPKI_KGE/0.jpg)](http://www.youtube.com/watch?v=IfRTPKI_KGE "Teaser video about the study")

The full dataset including raw data, mining scripts, and analysis R scripts produced during the study are available below.

This study has been designed, developed, and reported by the following investigators:
- Stylianos Rammos (Vrije Universiteit Amsterdam)
- Mansi Mundra (Vrije Universiteit Amsterdam)
- Guijing Xu (Vrije Universiteit Amsterdam)
- Chuyi Tong (Vrije Universiteit Amsterdam)
- Wojciech Ziółkowski (Vrije Universiteit Amsterdam)
- [Ivano Malavolta](http://www.ivanomalavolta.com/)  (Vrije Universiteit Amsterdam)

## How to cite this study
If this study is helping your research, consider to cite it is as follows, thanks!
```
@inproceedings{MOBILESoft_2021,
  title={{The Impact of Instant Messaging on the Energy Consumption of Android Devices}},
  author={Stylianos Rammos and Mansi Mundra and Guijing Xu and Chuyi Tong and Wojciech Ziółkowski and Ivano Malavolta},
  booktitle = {8th IEEE/ACM International Conference on Mobile Software Engineering and Systems 2021},
  year = {2021},
  pages = {to appear},
  url = {http://www.ivanomalavolta.com/files/papers/MOBILESoft_2021.pdf}
}
```

## Instructions for replicating the experiment

Here we provide instructions to run the experiment which measure the energy consumption of WhatsApp and Telegram.

### Interaction File

The `interaction.py` file contains experiment coordination code. It contains two methods `whatsapp_script()` 
and `tg_script()` which authenticate to the API of each respective application and send the messages programatically.
These methods take the same 3 parameters: 

1. `num_of_msgs`: total number of messages to send during the run
2. `sleep_btw_msgs`: time between each message (if applies)
3. `burst`: whether the messages should be sent all at once or not

 The `main` function contains the looped call to those methods. It also contains the logic to ensure that each
 run has the same duration. Finally, it contains the variables that specify the conditions of the run: 
 
1. `run_duration`: run duration in seconds (set to 300 seconds to reproduce the results of our experiments)
2. `sleep_btw_msgs`: time between messages in seconds
3. `num_of_msgs`: total number of messages to send
 
 ### Setup of the experiment 
 
 In order to reproduce the results of our experiments, follow the instructions given below to give the 
 correct values to each variable
 
 * RQ1 
 
 For this experiment the variables in `main` must be set as follows:

1. `run_duration`: 300
2. `num_of_msgs`: (msg per minute in treatment) * 5
3. `sleep_btw_msgs`: `run_duration` / `num_of_messages`
  
In the IM script method the burst parameter must be set to `False`. 

For example, the values for treatment 1 would be: 

`num_of_msgs` = 10 * 5 = 50

`sleep_btw_msgs` = 300 / 50 = 6

`burst`: `False`

* RQ2

For this experiment, the same as above applies for Treatment 1. 

For Treatment 2, the burst parameter must be set to `True`.
You may pass a value to `sleep_btw_msgs` but it will be ignored.

For example, the values for Treatment 2 would be:

`num_of_msgs` = 50 * 5 = 250

`sleep_btw_msgs` = `None`

`burst`: `True` 
