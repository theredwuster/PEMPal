# PEMPal

# Description
This repository contains the PEMPal application framework template and builds on top of the StanfordBDHG Template Application.  

Our application is an IOS and IOS watch application meant to help people with long covid by alerting them to overexertion and provides exercise alternatives, decreasing the likelihood of exacerbating chronic fatigue through post-exertional malaise.  
Users with long COVID experience high symptom burden with no clear treatment options or pathophysiological explanations. Post-exertional malaise (PEM) and chronic fatigue occur with a time-delay after strenuous physical activity. Users need a way to track their physical activity levels and modulate behavior to prevent PEM, given there’s no immediate feedback

This branch works with Xcode 14.1.0, Swift 5.7 and supports iOS 13 and above.
# Application Structure
The application uses the CardinalKit FHIR standard to provide a shared repository for data exchanged between different modules using the FHIR standard. You can learn more about the CardinalKit standards-based software architecture in the CardinalKit documentation.
# Build and Run the Application
You can build and run the application using Xcode by opening up the PEMPal.1.0.xcodeproj

# Dependencies
Xcode  
Swift   
HealthKit  
CardinalKit  
# Help
Feel free to contact us about any questions about the project or potential partnerships to help solve issues within the repository.
# Authors
Contributors names and contact info:  
Tim Wu -theredwuster@gmail.com   
Ian Hall–ihall3877@gmail.com  
Ahmed Yousif–ahmedyasiryousif123@gmail.com  
Andrew Churukian–drewchuruk@me.com  
Youngju Kim–youngju2001@gmail.com  
# Version History
1.1
Initial Release of application that tracks measurements used Healthkit anchored object query for WatchOS and IOS
# Acknowledgments/Contributors & License
This project is based on ContinousDelivery Example by Paul Schmiedmayer, and the StanfordBDHG Template Application provided using the MIT license

https://github.com/StanfordBDHG/CardinalKitTemplateApplication/tree/main/TemplateApplication
https://developer.apple.com/documentation/healthkit/hkanchoredobjectquery
https://www.devfright.com/how-to-use-healthkit-hkanchoredobjectquery/




## Onboarding Flow (Initialize View)

<img width="361" alt="Screenshot 2023-03-08 at 3 56 33 PM" src="https://user-images.githubusercontent.com/123029959/223880967-e76e8b8b-fc1d-406f-a0d1-22c6098a9425.png">


## Home Page (Home Page View)
<img width="358" alt="Screenshot 2023-03-08 at 3 56 57 PM" src="https://user-images.githubusercontent.com/123029959/223880902-9302e1ee-7f1c-45fc-998d-acdb0989b869.png">



## FAQ (Help Page)

<img width="350" alt="Screenshot 2023-03-08 at 3 57 23 PM" src="https://user-images.githubusercontent.com/123029959/223881006-ce5d2672-2c99-4114-b623-469ff020680b.png">

## Update Profile (Update Profile Page)
<img width="357" alt="Screenshot 2023-03-08 at 3 57 40 PM" src="https://user-images.githubusercontent.com/123029959/223880824-72f03d83-6c79-4968-bc12-ac99ff4813cc.png">



