import smtplib 
import json
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

infile = open("email.json", "r")
sms_info = json.load(infile)

email = sms_info["email_info"]["email_user"]
pas = sms_info["email_info"]["password"]
smtp = sms_info["email_info"]["smtp"]
port = 587

server = smtplib.SMTP(smtp,port)
server.starttls()
server.login(email,pas)

for __, value in sms_info["emails"].items():
    msg = MIMEMultipart()    
    sms_gateway = value
    print(sms_gateway)
    msg['From'] = email
    msg['To'] = sms_gateway
    msg['Subject'] = " The new mackbooks are in stock\n"
    body = " https://www.apple.com/us-edu/shop/buy-mac/macbook-air/with-m2-chip\n"
    msg.attach(MIMEText(body, 'plain'))
    sms = msg.as_string()
    server.sendmail(email,sms_gateway,sms)

server.quit()
