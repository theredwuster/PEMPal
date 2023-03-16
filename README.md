# PEMPal
This repository contains the PEMPal application, built in Stanford's Bioengineering Capstone (BIOE141). 

Patients with long COVID experience high symptom burden with no clear treatment options or pathophysiological explanation. The CDC estimates total cases of COVID-19 in America to be in excess of 103M, while the WHO places total confirmed cases at over 760M globally. In the US, roughly 10% of adults experience long COVID. This means ~10M patients in the US and ~76M patients globally suffer from long COVID.  

According to Mantovani et al, fatigue was the most commonly reported symptom in long COVID across multiple metastudies. Various triggers can lead to post-exertional malaise (PEM) and severe relapse of chronic fatigue syndrome (CFS). Of note, day-to-day physiological stressors are a major contributor, which can lead to an aggravation of symptoms lasting 14h to several days. These episodes are particularly challenging to manage because they occur with a time delay, meaning there's no immediate feedback for patients whether they're overexerting themselves in the moment.
Various triggers can lead to post-exertional malaise (PEM) and severe relapse of chronic fatigue syndrome (CFS).<sup>2,3</sup> Of note, day-to-day physiological stressors are a major contributor, which can lead to an aggravation of symptoms lasting 14h to several days.<sup>3</sup> These episodes are particularly challenging to manage because they occur with a time delay, meaning there's no immediate feedback for patients whether they're overexerting themselves *in the moment*.<sup>3</sup> 

The current idea centers around a wearable device to help patients track daily activities and alert as they approach the physical exertion threshold for PEM would help a) patients manage their activity level, and b) correlate ‘fatigue’ with tangible vitals measurements – giving physicians a way to track disease progression over time.

<img width="565" alt="Screenshot 2023-03-12 at 9 25 41 PM" src="https://user-images.githubusercontent.com/61076879/224608099-6dcbad32-ed89-4d8e-9aad-8ebeef27ac76.png">

The current application is capable of:

1. storing individual patient information,
  1. *Relevant Files*: Data -> globalModel.swift; Views -> InitializeView.swift, Update Profile Page.swift
3. querying for real time heart rate data in Apple Health,
  1. *Relevant Files*: Data -> globalModel.swift
4. changing an internal flag when patient self-reports PEM using the Report PEM button, andd
  1. *Relevant Files*: Data -> globalModel.swift; Views -> HomePageView.swift
6. updating home page UI to reflect the most recent PEM episode
  i. *Relevant Files*: Views -> HomePageView.swift

## Application Structure
The PEMPal application is an IOS application with integrations to Apple Health vitals data using [HealthKit](https://developer.apple.com/documentation/healthkit) (HK). The current version contains two main pages (Onboarding page, Home page) and two prototype pages (FAQ, Update profile page). These pages are described in more detail below.

This version also has a prototype WatchOS application with a Report PEM button and a Risk description that changes on button press. Integrating an iPhone app with the watch is much more complicated than we initially thought for several reasons: 

1. the watch operates off a local HealthStore doesn't always sync data with the overarching HealthStore actively (watch and phone app might access different underlying data), 
2. the watch-phone integration requires significantly more work, and 
3. if any 3rd party hardware was used to collect non-heart rate data it would sync with the phone HealthStore rather than the watch. 

As a result, and since the Apple Watch Series 5 we tested with doesn't measure SpO2, BP, or RR, the current prototype of the app strictly works an iOS app (so we can rely on the phone HealthStore as the source of truth) and heart rate (the main vital measured by the Apple Watch). A hacky workaround we've devised for this is to set the watch to workout mode (any workout) when we use our app; during a workout, the watch [continuously samples](https://support.apple.com/en-us/HT204666#:~:text=When%20Apple%20Watch%20measures%20your,heart%20rate%2C%20check%20your%20settings.) heart rate every ~5 seconds and immediately pushes updates to the overarching HealthStore. In this way, without building an explicit WatchOS app, we're still able to measure vitals using a watch and pull that data into our iOS app.

> Since older versions of the Apple Watch don't measure SpO2 and even the Apple Watch 8 doesn't measure blood pressure or respiratory rate (when active), focusing our build on the iOS app means the PEMPal app would be cross-compatible with third party hardware. As long as external hardware syncs with Apple Health, we could measure blood pressure or respiratory rate, sync with Apple Health and the iOS HealthStore, and run our analyses. **These third party devices (and thus more complicated vitals) would not sync to the WatchOS app/watch HealthStore**

Within the scope of the class, we built out majority functionality in the iOS app and decided to retain a basic looks-like prototype for the WatchOS app. 

Variables within the application are stored within a <code>Global Model</code> Swift file, which serves as the central repository for all values we track once initialized. This includes both vitals data (heart rate, respiratory rate, blood pressure) and patient specific information (name, age, weight, days since last PEM).

This app was built using Xcode 14.1.0, Swift 5.7 and supports iOS 13 and above.

## Build and Run the Application
You can build and run the application using [Xcode](https://developer.apple.com/xcode/) by opening **PEMPal.1.0.xcodeproj**. Note that if the application is being tested on:

1. An XCode simulator - remember to manually add heart rate data into the Apple Health app in the simulator
2. A physical iPhone - start a workout on your connected Apple Watch, open Apple Health to make sure the watch is actively measuring heart rate data and feeding it to Apple Health. The PEMPal app make take a few seconds to update the HR value, try opening/closing the app (without ending the app process).

## Global Model
Our <code>Global Model</code> Swift file is meant to function as a central repository for all our variables. This includes both vitals data (heart rate, respiratory rate, blood pressure) and patient specific information (name, age, weight, days since last PEM).

Different queries and views should communicate with <code>Global Model</code>, which stores several published variables. The published attribute ensures that all 'subscribed' views will receive an updated value if a published variable changes. This is in line with best practice as want our views to be primarily responsible for the visual UI that is displayed, rather than processing or storing information.

<code>Global Model</code> is also where we initialize HK authorization (user gives consent to access vitals information) and run our <code>HKAnchoredObjectQuery</code>. The <code>AnchoredObjectQuery</code> is distinct in that it returns an anchor value such that subsequent queries only retrieve data added *after* the anchor. In other words, this query allows us to continuously update and query from HealthStore in the background as opposed to running a completely new query every time. Our query sets an anchor, retrieves the latest heart rate value from HealthStore and formats it, updates the anchor, and stores the value in <code>Global Model</code>. An update handler continuously runs this query in the background.

## Onboarding Page (Initialize View)
The <code>Onboarding Page</code> contains a place where patients can enter their name and self-report physiological characteristics such as weight, height, age, activity level, COVID history, whether they were hospitalized due to COVID, severity, length of symptoms. These charactersitics are important based on the papers cited in the references for important factors whether a patient risks PEM episodes. Further, this information would allow us to calibrate our predictive model to each individual patient.

<img width="361" alt="Screenshot 2023-03-08 at 3 56 33 PM" src="https://user-images.githubusercontent.com/123029959/224572716-08a8993b-c5d2-4187-9b0b-7a284a780067.png">

> **Implementation:** The <code>Onboarding Page</code> is enclosed within a <code>Navigation Stack</code> comprising of various text fields nested within a form. These fields receive user text-based input and store the results in <code>Global Model</code>, as mentioned above. Dropdown options are built using <code>Menu</code> blocks and the Continue button is a <code>Navigation Link</code> that directs to the home page. The back button is purposefully removed here since we don't want users to be able to navigate back to the Onboarding Page once they've submitted their information.

## Home Page (Home Page View)
The <code>Home Page View</code> is meant to function as a quick, simple snapshot of the patient's current health and PEM risk assessment. The Home Page provides summary vitals data, displays PEM status, and holds the Report PEM button. Generally, highly rated digital health apps incorporate automatic reminders and alerts (eg. for ingestion of medicine or upcoming medical appointments)<sup>3</sup>. General usability dictates there should also be a clear and accessible view of summary vitals and current PEM risk, since these are the features most relevant and frequently accessed by patients; as such, these are captured via the <code>Home Page View</code>.

The <code>Home Page View</code> contains:  

A <code>Heart Rate Display</code> designed to display updated heart rate vitals from the heart rate query that updates through the <code>AnchoredObjectQuery</code> for patients to see and monitor. The <code>Heart Rate Display</code> also contains information about what a healthy range. Our heart rate range is based upon the CDC’s estimate for a heart rate with moderate-intensity physical activity and has the lower bound of this range being 220 minus patients age multiplied by .64 and the upper bound of this range being 220 minus the patients multiplied by .76. 

A <code>Blood Pressure</code> and a <code>Respiratory Rate</code> placeholder that currently displays dummy values within the regular range for healthy humans under exercise. Witchum et. al<sup>5</sup> found that heart rate, respiratory rate, and blood pressure as the most relevant indicators for PEM. These ranges would indicate thresholds for healthy blood pressure and respiratory rate and warn patients at risk for PEM if they exceed this range. One of the main reasons the current iteration of our app doesn't update blood pressure or respiratory rate is because the Apple Watch is currently incapable of measuring BP or RR during exercise. Given the watch is the main mechanism for us to intake patient vitals, our options are either to a) remove these vitals or b) incorporate new hardware. Theoretically, the Apple Watch may in the future be able to measure these vitals **OR** as long as patients use 3rd party hardware that syncs with Apple Health, our app would be compatible. Thus, a future iteration of our application would exist without this hardware limitation, query for HR/BP/RR, and use all 3 vitals within a predictive model to set patient risk thresholds for PEM.

A <code>Report Pem Button</code> designed to enable patients to log the occurrence of a PEM episode. This was added to the homepage for ease of access and will likely be essential later to help the model integrated into the app recognize and appropriately adjust fatigue threshold levels in accordance with the patient’s changing physical state. Pressing this button also resets the days since last PEM status to 0 days and keeps accuracy of PEM history. 

A <code>Navigation Bar</code> created with icon buttons (copied over from the Basic Figma Icon Library) that represent the home, history, help and menu pages. This feature is to allow for easy navigation between the different pages, and was added to the bottom of every main page.

<img width="415" alt="Screenshot 2023-03-14 at 11 30 56 PM" src="https://user-images.githubusercontent.com/61076879/225225430-246d8bc2-bb0f-44d5-92bf-46bec81df3dc.png">

> **Implementation:** The <code>Home Page View</code> is comprised of several internal views. The main view is fed our <code>Global Model</code> to carry over patient information from our <code>Onboarding View</code>. The page itself consists of text and different subviews nested within a <code>ScrollView</code>. Patient heart rate and previous PEM episode displays values pulled from <code>Global Model</code>. Note that while respiratory rate and blood pressure are retrieved from <code>Global Model</code>, these values are currently hard coded placeholders as this version of the app only pulls heart rate data from HealthStore (as mentioned in *Application Structure*). 

## FAQ (Help Page)
The <code>Help Page</code> is set up with options to report a problem with the app, information on privacy and security and an FAQ section/guide to using the PEM Pal app. None of these are currently clickable links but will be in the future.

<img width="350" alt="Screenshot 2023-03-08 at 3 57 23 PM" src="https://user-images.githubusercontent.com/123029959/224572667-1ac74bff-c9d4-46ed-b666-f5a98ffa99e9.png">

> **Implementation:** This page consists of various headings and associated buttons with nested <code>NavigationLink</code> to different pages. In this version, these pages have not been built out and currently all lead to a logo page but may redirect to the appropriate views (report a problem, FAQ, terms and conditions) in the future.

## Update Profile (Update Profile Page)
The <code>Update Profile Page</code> allows patients to update their metrics to after their inital entry via the onboarding workflow. This could be useful if patients have a drastic change in weight, height, or any other relevant metric. This page is important because, as previously mentioned under the Onboarding flow, a good predictive model should be capable of receiving patient-specific inputs and calibrating *different* risk thresholds for different individuals. As above, our basic prototype heart rate range under exercise is already calibrated based on age; the ideal end state of this app would calibrate and adjust PEM risk thresholds based on a multitude of individual features (perhaps pulled from an EMR).

<img width="357" alt="Screenshot 2023-03-08 at 3 57 40 PM" src="https://user-images.githubusercontent.com/123029959/224572695-1857a00a-19f5-444d-b254-df660ab5cdf0.png">

> **Implementation:** The <code>Update Profile</code> view functions very similarly to the onboarding view, whereby patient specific information is displayed in text fields and values are pulled from <code>Global Model</code>. Any changes made in the corresponding text field also modifies the source value stored in <code>Global Model</code>.

## WatchOS Preview
The watch app currently exists as a minimally functional looks-like prototype. As mentioned above, the watch and iPhone stores health information in separate HealthStores locally and it isn't clear when these two sync under normal non-workout conditions. It was also much more difficult than expected to build a connection between a watchOS app and an iOS app. As a result, the current watch app doesn't pull live heart rate information but simply displays a placeholder value (0), with a risk estimator underneath that simply switches from "Low" to "High" risk when the button is pressed.

<img width="294" alt="Screenshot 2023-03-12 at 1 54 10 PM" src="https://user-images.githubusercontent.com/123029959/224573087-d9854dd3-29b9-425d-9548-ea0a89f5d36a.png">

> **Implementation:** The watch app consists of text wrapped in a ScrollView, with a button that modifies the displayed risk string when pressed.

## Dependencies
Xcode  
Swift   
HealthKit

## Authors
Feel free to contact us with any questions about our project!

Contributors names and contact info:  
Tim Wu - theredwuster@gmail.com   
Ian Hall – ihall3877@gmail.com  
Ahmed Yousif – ahmedyasiryousif123@gmail.com  
Andrew Churukian – drewchuruk@me.com  
Youngju Kim – youngju2001@gmail.com  

# Version History
1.0 - Initial Release of application tracking only heart rate measurements using the HealthKit AnchoredObjectQuery. Current deployment targets are for WatchOS 9.1 and iOS 16.2.

# Acknowledgments
Huge thanks to Paul Schmiedmayer, Oliver Aalami, and the [Stanford Biodesign Digital Health Group (BDHG)](https://biodesign.stanford.edu/programs/stanford-courses/biodesign-for-digital-health.html) teaching staff for their help and guidance throughout the course. This app draws inspiration from the [Stanford BDHG Cardinal Kit Template](https://github.com/StanfordBDHG/CardinalKitTemplateApplication/tree/main/TemplateApplication) although the existing version and all associated functionality is built from scratch.

# References
1. Mantovani, A.  et al., 2022 Sept; 29: 1891–1900 [Nature](https://www.nature.com/articles/s41418-022-01052-6)  
2.Mackay, A. Front. Neurol. 2021 Aug; 12: 701419. [PubMed](https://pubmed.ncbi.nlm.nih.gov/34408721/)
3. Kedor, et al. Nature Comm. 2022 Aug; 13: 5104. [Nature](https://www.nature.com/articles/s41467-022-32507-6)
4. Subramanian, A. et al.  Nat Med. 2022 Jul; 28: 1706–1714. [Nature](https://doi.org/10.1038/s41591-022-01909-w)
5. Mendiola M et al. JMIR mHealth and uHealth. 2015 Apr; 3(2): e(40). [PubMed](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4446515/)
6. Wichum F et al. Current Directions in Biomedical Engineering. 2021 Oct; 7(2): 371-374. [De Gruyter](https://www.degruyter.com/document/doi/10.1515/cdbme-2021-2094/html)
7. Biswas M, et al. PLOS ONE. 2021 Dec; 16(12): e0258050. [PLOS ONE](https://doi.org/10.1371/journal.pone.0258050)
8. CDC. "Target Heart Rate" 2023. [CDC](https://www.cdc.gov/physicalactivity/basics/measuring/heartrate.htm#:~:text=You%20can%20estimate%20your%20maximum,beats%20per%20minute%20(bpm))

