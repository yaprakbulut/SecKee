<p align="center">
  <img  src="https://user-images.githubusercontent.com/36481108/122676842-6a3e0780-d1e8-11eb-8293-73ab3f83dcd5.jpeg">
</p>

# Project Owners

*Yaprak BULUT - 20160808005*

*Canberk ATBİNİCİ - 20160808016*

# Table of Contents

- [Introduction](#introduction)
- [Methodology](#methodology)
  * [1. What is AES Encryption?](#1-what-is-aes-encryption-)
    + [1.1. Structure of AES Algorithm](#11-structure-of-aes-algorithm)
    + [1.2. Encryption Steps](#12-encryption-steps)
    + [1.3. Security of AES Algorithm](#13-security-of-aes-algorithm)
    + [1.4. Advantages](#14-advantages)
  * [2. Hive](#2-hive)
- [Implementation](#implementation)
- [Demo](#demo)
- [References](#references)

<a name="introduction"/>

# Introduction

  We need a password to connect to all our digital accounts, and these passwords need to be quite complex. Instead of setting a single password and using it everywhere, it causes many security vulnerabilities.

  When we say our e-mail account, social media platforms, digital monitoring platforms, digital listening platforms, online shopping sites, we have dozens of different digital accounts and we need to set a password when logging into each one. 

  Many users set a unique password for themselves and use that password everywhere. However, this situation reveals extremely important security vulnerabilities for the user. This is where the SecKee application comes into play. You can use SecKee to minimize potential security threats. Instead of setting a standard password, you can hide your virtual world behind strong walls by using such an application.

  We have established a three-layer security system in our application. The first is fingerprint authentication, the second is the encryption of the password itself, and the third is the encryption of the entire database.

  SecKee does not store passwords in cloud storage. It stores it in the device's own local storage. Thus, it protects against possible online threats and data leaks. Depending on the device on which the application is installed, you can use a fingerprint or pin code.

<a name="methodology"/>

# Methodology

<a name="1-what-is-aes-encryption-"/>

## 1.	What is AES Encryption?

  AES is defined as the “Advanced Encryption Standard” used as an abbreviation for Advanced Encryption Standard. It was announced on October 21, 2001, upon breaking the DES encryption algorithms previously produced by scientists. In this way, it started to be used instead of the DES encryption algorithm. AES, accepted by the American government, is also used internationally as a defacto encryption (crypto) standard. It is a standard for the encryption of electronic data. It is a block cipher algorithm created with mathematics by completely correcting the weaknesses of DES, which was found by Belgian Vincent Rijmen and Joan Daemen.

  The encryption algorithm defined by AES is a symmetric and keyed algorithm in which the keys used for both encryption and decryption are related to each other. The encryption and decryption keys for AES are the same. Standardization was completed after a period of 5 years. In this process, 15 different designs were presented as AES candidates, and after these algorithm designs were evaluated in terms of security and performance, the most suitable design was chosen as the standard encryption algorithm. It was officially activated on May 26, 2002, following the approval of the US government. Its origin dates back to 1997 and its development continued until it was published.

<a name="11-structure-of-aes-algorithm"/>

### 1.1.	Structure of AES Algorithm

  The basis of AES is based on the replacement-scrambling design. The data to be transmitted is passed through the necessary encryption layers and is basically transformed into an unreadable, meaningless data set. These encryption operations are performed according to a certain key matrix. The receiving side, after receiving the data, needs a key to decrypt it and return it to its meaningful form. This key must be the same as the key with which the data is encrypted. In this way, the receiving side will obtain the data when the steps applied in the encryption process are applied in the opposite direction.

  The input data to be encrypted by AES has a length of 128 bits. There are three different key lengths to encrypt this data. These are 128,192 and 256-bit encryption. As the key length to be used in encryption increases, the security will increase to a higher level, but it will also bring performance and speed degradation. There are 10 rounds of encryption for 128-bit encryption, 12 for 192-bit encryption, and 14 rounds of 256-bit encryption.

<a name="12-encryption-steps"/>

### 1.2.	Encryption Steps

AES performs encryption operations on a 4×4 column priority byte matrix structure. In the encryption process, the encryption process is performed by following certain steps and repeating this order in a certain cycle.

In the first step, the key to be used for encrypting the data is generated. There are techniques required for key generation.

After key generation, the data to be encrypted is converted into a 4×4 state matrix. This data, which is converted to a matrix, is entered into the 'XOR' operation with the generated key. The transactions made so far are for once only.

In the second step, the matrix obtained as a result of the first step is subjected to a displacement operation according to a predefined table named “S-box”. Relocation is done as follows. Let's say one of the elements of the data matrix corresponds to the hexadecimal number '0x36'. This number will be replaced by the element in the 3rd-row 6th column in the replacement table. This operation is applied to all elements of the matrix.

<p align="center">
  <img src="https://user-images.githubusercontent.com/36481108/122677291-68754380-d1ea-11eb-9ed3-a43e6fd7204f.PNG">
</p>

Subsequent operations are performed by altering the rows and columns of the new matrix obtained and then interacting with the key.

In the third step, line wrapping is done. Elements in the lines are shifted to the left by one less than the line number. That is, while the first row elements are not changed, the second-row elements are shifted one unit to the left. The same logic applies to other elements.

<p align="center">
  <img  src="https://user-images.githubusercontent.com/36481108/122677338-a1151d00-d1ea-11eb-9cf5-4427a40a51dd.png">
</p>

The fourth step is column mixing. In this step, the resulting new matrix is multiplied by a fixed matrix. As a result of the operation, a new matrix is obtained.

<p align="center">
  <img  src="https://user-images.githubusercontent.com/36481108/122677385-c144dc00-d1ea-11eb-91d0-7a20285560ed.png">
</p>

In the fifth step, the obtained new matrix and key matrix elements are subjected to 'XOR' operation. The matrix result obtained here is used as the input for the next step. At the same time, a new key is generated at each new stage.

Column and row operations are repeatedly applied 10, 12, or 14 times, according to the bit encryption length of AES, as indicated above. The point to be noted here is that the column mixing process performed in the fourth step is not applied in the last cycle to be performed. After this process, the encrypted data is transmitted to the receiver side. The receiving side must have the key used for encryption and decrypt the data encrypted with this key by performing reverse operations.

<a name="13-security-of-aes-algorithm"/>

### 1.3.	Security of AES Algorithm

In the AES encryption technique, the most important criterion is the key matrix. While this matrix is known by the receiver and transmitter, it is not known by the system that wants to attack, so the attacking system must try all possible key combinations and have the correct key among them. In this case, in order to crack a data encrypted with a 256-bit key, a password cracking algorithm with an approximate 2 power of 200 must be implemented. This number is proof of how low the probability of breaking the AES algorithm is and its reliability is at a very high level.

All key lengths of 128, 192, and 256 bits can be used on all data in confidential order. For top-secret data, keys with key lengths of 192 and 256 bits are generally used.

AES encryption has many uses, from VPN applications to messaging applications, from game developers to individual purposes, and is one of the most preferred and hardest to crack encryption methods today.

<a name="14-advantages"/>

### 1.4.	Advantages

* High security
* Fast work
* Working with less memory
* Flexibility
* Hardware-software compatibility

Cyber attacks are at the forefront of the dangers brought by technology today, and these attacks endanger basic requirements such as the protection of private data for individuals and institutions, and the protection of developed products. The developed AES encryption method, on the other hand, has no known anti-algorithm and creates an excellent firewall against these dangers. Therefore, it is widely used in many electronic systems as integrated into software and hardware.

<a name="2-hive"/>

## 2. Hive

<p align="center">
  <img  src="https://user-images.githubusercontent.com/36481108/122679144-6e6f2280-d1f2-11eb-95b7-c0f24ef16962.png">
</p>

Hive is a NoSQL database that allows us to record the data we want to keep in our phone's own memory with key,value values and to perform operations on our data.


In relational databases, we manage our data under tables by establishing relationships with other tables (if necessary). While operating on Hive, we store our data with objects that we express as boxes.

We can say that the working logic is like SharedPreferences. As the data we want to work with increases, it is much more performant than Hive alternatives. Of course, the important thing here is which structure is more suitable for our application. We prefer relational or NoSQL database according to the data we want to manage.

The biggest advantage of the Hive database is that the speed of writing and reading large data is very low compared to other databases. It can do 1000 read and 1000 write iterations in almost zero milliseconds. With these speeds, you can read and use the data you want synchronously or perform other operations.

Another possibility that Hive offers is that you can save different data models that you have created and you can save them in list format if you want. You can save and use this data, which you have saved as a Map in the Key-Value format, either with the 'key' you will use, or as the automatic index offered by Hive.


<p align="center">
  <img width="600" height="400" src="https://user-images.githubusercontent.com/36481108/122679238-c0b04380-d1f2-11eb-8b0c-614d1c1a798f.PNG">
</p>

<a name="implementation"/>

# Implementation

First of all, when you click on the application, you will encounter a simple error if your fingerprint or face recognition is not registered on your phone. If you do not have either of these two on your phone, you cannot log in to the application. That's why we put an error message here asking you to adjust this setting.

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122689218-b65d6c00-d229-11eb-8463-32462f54a872.jpeg">
</p>

In the below screen, you can see SecKee authentication page. Here, we use local bio authentication. You can use this application only when the phone is in your hand. Therefore, no one but you can access it. Also, we don't use pins or passwords, so your bio or fingerprint is needed to log in to the app. If you click on the logo more than five times and click on the "Click here for authentication" button, the bio authentication will open. If you do not follow this procedure, you will never be able to log in.

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122689230-cc6b2c80-d229-11eb-9e40-d7b48e551b42.jpeg">                         
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122689232-cecd8680-d229-11eb-9652-759f34db97ae.jpeg">
</p>

In addition, there is another important point that increases the security of the application. If you just press the home screen or send your app to recent apps the app instance will be cleared. So if you open it up again you will have to re-authenticate yourself.

<p align="center">
  <img width="260" height="500" src="https://user-images.githubusercontent.com/36481108/122689474-5ff12d00-d22b-11eb-907d-89c521d5bf94.jpeg">
</p>

After logging in, the passwords page welcomes us. We have encrypted passwords using AES in our app. When the password is entered, instead of storing this password directly as a string, we encrypt the string and then store it. We store the value and then we decrypt it. We also use encrypted storage since we are using a local database. This is more vulnerable to attack, that's why we store it using an encrypted database from the hive. 

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122689713-7304fc80-d22d-11eb-8c71-ba2e5fd932e6.jpeg">
</p>

When we click the plus button, add password screen opens. Here, the registration is created by entering the application, website, etc. name, user name, and password. The data we enter in the Service field is displayed as a title in the list, and you can see the user name under the title. In addition, icons are shown depending on the entered service name. 

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122690193-be6cda00-d230-11eb-9427-a77fb134fa4a.jpeg">                         
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122690197-c62c7e80-d230-11eb-939c-f55a03cd7378.jpeg">
</p>

As you can see, passwords are not shown in the records in the list. We can copy the password to the clipboard by clicking the copy icon on the card. We can then use this password wherever we want. 

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122690294-4f43b580-d231-11eb-8ffd-c2358c205399.jpeg">
</p>

The delete button is accessed by swiping the card to the left. After clicking the button, confirmation is requested for the deletion process. After the deletion is confirmed, the selected data is removed from the database. This action cannot be undone.

<p align="center">
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122690355-c4af8600-d231-11eb-8997-f069e4037d3c.jpeg">                         
  <img width="270" height="500" src="https://user-images.githubusercontent.com/36481108/122690358-c6794980-d231-11eb-807e-8d4c7315a113.jpeg">
</p>

<a name="demo"/>

# Demo 

##### Youtube link: <a href="https://youtu.be/tRzwu_yurDU">https://youtu.be/tRzwu_yurDU</a>

https://user-images.githubusercontent.com/32189700/122691554-14de1680-d239-11eb-80c3-15dc3ca50771.mp4


<a name="references"/>

# References

* <a href="https://pub.dev/packages/hive">Hive documentation</a>

* <a href="https://docs.hivedb.dev/#/basics/hive_in_flutter">Hive in Flutter</a>

* <a href="https://blog.codemagic.io/flutter-local-authentication-using-biometrics/">Flutter Local Authentication using Biometrics</a>

* <a href="https://pub.dev/packages/encrypt">encrypt 5.0.0</a>

* <a href="https://www.educba.com/encryption-vs-decryption/">Encryption vs Decryption</a>

* <a href="https://pub.dev/packages/local_auth#:~:text=This%20Flutter%20plugin%20provides%20means,(introduced%20in%20Android%206.0).">local_auth</a>

* <a href="https://www.guru99.com/difference-encryption-decryption.html">What is Cryptography?</a>

* <a href="https://medium.com/@monetha/what-are-encryption-and-decryption-256cb00e7e6e">What Are Encryption and Decryption?</a>

* <a href="https://searchsecurity.techtarget.com/definition/Advanced-Encryption-Standard">Advanced Encryption Standard (AES)</a>

* <a href="https://www.trentonsystems.com/blog/aes-encryption-your-faqs-answered">What Is AES Encryption? [The Definitive Q&A Guide]</a>


