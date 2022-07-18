# M2-Availability
##  **Description**
M2-Availability is a group of simple scripts that are ran at minute intervals to check whether the new Macbooks are instock. When in stock, a text message and email is sent to notify the user.

<br>

---

<br>

## **What you will need**
* A VPS or other means of consistently running the scripts
* Crontab schedule manager
* Phone numbers and Emails of users to notify
  * Need to know sms and smtp gateways 

<br>

---

<br>

## **How to run**
## Steps:
1. Change permissions of scripts to be run as executables
2. Create two files **'mail.txt'** and **'number.json'**
3. Create curl command with email information
4. Set up crontab to schedule script execution with minute intervals

<br>

### **Firstly**, would be to download all of the scripts within the repo **obviously**. You will also need to change the permissions of the scripts **'sms.py'** and **'is_m2_available.sh'** and make sure they can be run as executables. The command for that is -->

        chmod +x scriptname.sh      
        # Change 'scriptname' with correct file name

<br><br>

### **Secondly**, you will have to create two separate files named **'mail.txt'** and **'number.json'**
In **'mail.txt'** I gave a super simple outline that you can create the text file with. The only thing you would need to change would be the sender and receiver fields for the email. Now for **'number.json'** you will just need to input your smtp information for whatever email you are with. Yahoo uses the provided one in the example but something like Gmail would use **'smtp.gmail.com'**. The second part of this is you will have to create the key and value for the phone numbers you want to send the message to. Just use the same syntax as the example. In the example, you just replace the value with your phone number and then you have to put the correct sms gateway after the **'@'** symbol. Here is a [link](https://www.liquisearch.com/list_of_sms_gateways) of sms gateways for all the different service carriers. 

<br>

**mail.txt**  
```
    From: "name" <email@yahoo.com>
    To: "name" <email@gmail.com>
    Subject: Macbooks are instock 
    Content-Type: text/html; charset="utf8" 

    <html>   
        <body>     
            <style>         
            .card{
                 box-shadow:0 4px 8px 0 rgba(0,0,0,0.2);
                 transition: 0.3s;
                 border-radius: 5px;
                 width: 300px;
                 height: 150px;
             }
             .container,
             .card-title,
             .card-text {
                 padding: 2px 16px;
             }
             img{
                 border-radius: 5px 5px 0 0;
             }
         </style>
         <div class="container">
           <p>Hey, the new Macbooks are now instock!</p>
             <div class="card">
                 <div class="card-body">
                     <div class="card-body">
                         <h2 class="card-title">M2 Macbook Link</h2>
                         <div class="card-text">
                             <a href="https://www.apple.com/us-edu/shop/buy-mac/macbook-air/with-m2-chip" class="btn">
                                 <img src="https://cdn-icons-png.flaticon.com/512/0/747.png" width="60" height="60">
                             </a>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
       </body>
     </html>
```
<br>

**number.json**
```
        {
    "email_info": 
        {
            "email_user": "your_email",
            "password": "your_password",
            "smtp": "smtp.mail.yahoo.com",
            "port": "587"
        },
    
    "numbers": 
        {
            "gate1": "phone_number@txt.att.net",
            "gate2": "phone_number@txt.att.net"
        } 
    }
```

<br><br>

### **Thirdly**, you will have to create another text file called **mail_info.txt** that contains all of the mail information in order to send emails. Obviously just replace the values in that file with the correct email information and get rid of the quotations as well.

<br>

**mail_info.txt**
```
stmp=smtp.mail.yahoo.com or other email smtp gateway
port=587
sender="your_email"
password="your_email_password"
from="your_email"
receiver="email_you_want_to_send_to"
receiver="email_you_want_to_send_to"
```

<br><br>

### **And lastly,** you will have to setup crontab

If you are not familiar with crontab, here is a [link](https://phoenixnap.com/kb/set-up-cron-job-linux) to get familiar with it. In crontab, I wrote this job to be run every 3 minutes:
        
    */3 * * * * /root/M2-Availability/is_m2_available.sh
Experiment with this and try to get it up and running. On Centos, I used `service crond status` to check whether or not crontab was doing what it was supposed to be doing. Don't forget to make sure crontab is running with `service crond start`

That should cover it!

---