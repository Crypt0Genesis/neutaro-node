# Neutaro Validator Node Deployment Script

```
Crypto-Genesis Neutaro Validator:

https://nms1.neutaro.tech/Neutaro/staking/neutarovaloper1axnf92t5qzcxvxhkkzj2j605apazsz90jx9cs9

Account Address:
neutaro1axnf92t5qzcxvxhkkzj2j605apazsz90gmg3a7

Operator Address:
neutarovaloper1axnf92t5qzcxvxhkkzj2j605apazsz90jx9cs9
```

************************************************************************************************************************
Welcome to the Neutaro Validator Node Deployment Script repository! The primary objective of this script is to facilitate seamless and error-free deployment of the Neutaro Validator Node. This script offers a significant advantage by enabling almost 100% Zero Touch Provisioning (ZTP) of the validator node server.

Our principal aim is to offer deployment tools and support to the community, streamlining the process of deploying our Neutaro Network with minimal hassle.

************************************************************************************************************************

**Key Features:**

**Seamless Deployment:**
The script streamlines the deployment process, ensuring a hassle-free experience.

**Error-Free Execution:** 
With careful design and testing, the script minimizes the occurrence of errors during deployment.

**ZTP Provisioning:**
Enjoy the convenience of almost 100% Zero Touch Provisioning, reducing manual intervention.

**Efficient Installation:**
The approximate installation time ranges between 10 to 15 minutes, enabling swift setup of the validator node server.

************************************************************************************************************************

**System Requirements**


1) Operating System: Ubuntu

2) Sudo Permissions with No Password Prompt:
To disable the password prompt for sudo privileges, follow these steps:

Open the sudoers file using the command: 
```
sudo visudo

Add or replace the following line to the file:

#Allow members of group sudo to execute any command#

%sudo   ALL=(ALL:ALL) NOPASSWD:ALL

Save and exit the file. "Ctrl + x -> Y and Enter"
```
3) "git" if not installed, you can install it from the following link:
```
sudo apt install git
```

**Automatic Node Activation:** 
Initiates the validator node automatically upon completion of the installation process, ensuring immediate functionality.

**Usage:**
To deploy your Neutaro Validator node using this script, simply execute the deployment script and follow the on-screen prompts.

**Getting Started:**
To get started with deploying your OraiChain Validator node using this script, follow these simple steps:

************************************************************************************************************************

Installation Instructions:

1. **Download the Files:** Retrieve the necessary files onto your server.
   ```
   cd $HOME
   sudo git clone https://github.com/Crypt0Genesis/neutaro-node.git
   ```
2. ""Go to the downloaded folder "neutaro-node"
   ```
   cd neutaro-node
   ```
3. **Permissions:**
   Set executable permissions for the `neutaro-setup.sh` :
   ```
   sudo chmod +x neutaro-setup.sh
   ```
  
4. To deploy your Neutaro Validator node using this script, simply execute the deployment script and follow the on-screen prompts:
   ```
   ./neutaro-setup.sh
   ```

 ************************************************************************************************************************

**NOTE**

I've thoroughly tested the script and it operates flawlessly. However, I welcome your feedback and suggestions for further enhancements. Feel free to reach out with any concerns or improvement ideas. Thanks!

**************************
Crypto-Genesis Validator:
https://t.me/crypt0genesis
**************************

