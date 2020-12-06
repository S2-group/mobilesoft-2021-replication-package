# Instant Messaging (IM) Applications Energy Consumption

Here we provide instructions to run the Android Runner experiments 
which measure the energy consumption of WhatsApp and Telegram.

## Interaction File

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
 
 ### Setup for Experiment 
 
 In order to reproduce the results of our experiments, follow the instructions given below to give the 
 correct values to each variable
 
 * RQ 1 
 
 For this experiment the variables in `main` must be set as follows:

1. `run_duration`: 300
2. `num_of_msgs`: (msg per minute in treatment) * 5
3. `sleep_btw_msgs`: `run_duration` / `num_of_messages`
  
In the IM script method the burst parameter must be set to `False`. 

For example, the values for treatment 1 would be: 

`num_of_msgs` = 10 * 5 = 50

`sleep_btw_msgs` = 300 / 50 = 6

`burst`: `False`

* RQ 2

For this experiment, the same as above applies for Treatment 1. 

For Treatment 2, the burst parameter must be set to `True`.
You may pass a value to `sleep_btw_msgs` but it will be ignored.

For example, the values for Treatment 2 would be:

`num_of_msgs` = 50 * 5 = 250

`sleep_btw_msgs` = `None`

`burst`: `True` 
