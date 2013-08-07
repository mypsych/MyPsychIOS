//
//  FeelingInfoViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/20/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "FeelingInfoViewController.h"

NSString* const kWellbeingBriefInfoText[WELLBEING_MINIMUM_COUNT] = {
    @"How did you feel yesterday?",
    @"How do you feel today?",
    @"How will you feel tomorrow?",
    @"How much energy do you have today?",
    @"How do you feel about the weather today?",
    @"How many hours did you sleep today? If you slept 8.5 hours, round down to 8."
};

NSString* const kLifestyleBriefInfoText[LIFESTYLE_MINIMUM_COUNT] = {
    @"This one is tricky. 0 means you have a lot of stress or do not feel good about your stress. 10 means you do not have a lot of stress or you feel good about your stress.",
    @"Are you in a good mood today?",
    @"Are you feeling fit and active today?",
    @"Are you eating healthy today?",
    @"How do you feel about your social life today?",
    @"How do you feel about your romantic life today?"
};

NSString* const kWellbeingSpecificLowInfoText[WELLBEING_MINIMUM_COUNT] = {
    @"If your Yesterday value is consistently between 1-3, take a moment to think about if there was a specific incident that could be attributed to this low score. Pay close attention to your Today and Tomorrow values.  Are your feelings about Yesterday having an impact on them?  Also, take a look at your other values from that day. Scores of 1-3 indicate something troubled you in that area. These charts can help you identify areas you can work on to feel better. If you’re able to identify something specific that troubled you, use the Personal Chart to work on it over time.  For example, if you were late to work and this attributed to your bad day, try monitoring getting to work on time. Acknowledging the things that are causing problems is the first step to solving them.",
    @"If your Today value is consistently between 1-3, you may be regularly having bad days. Take a moment to think about what specific activities are bringing you down.  Is it anything that can be helped or is something you have to cope with?  If it’s a specific activity, think about what can help make it better. Pay close attention to your other values, particularly the values for Stress, Social Life, Romantic Life, Weather, Today, Tomorrow and Hours Slept.  If you are finding scores of 1-3, this may indicate an area that could be attributing to your negative feelings about the day.  Use the Personal Chart to monitor something you can try to incorporate in each day to improve it.",
    @"If your Tomorrow value is consistently between 1-3, you may be unhappy about something you regularly have to do. Pay close attention to the Stress, Mood, Fitness, Nutrition, Social Life, Romantic Life, Hours Slept, and Energy values.  Scores of 1-3 can indicate potential problem areas. If over time you are giving yourself a score between 1-3 for Tomorrow, you would benefit from making a list of the things in your life that are causing you trouble.  Start with one thing on that list and think if there’s something you can do to make it better.  Use the Personal Chart to monitor an activity that you would like to increase or decrease in an effort to improve your day.",
    @"If your Energy value is consistently between 1-3, you may be feeling depleted or unenergetic.  Take a good look at your scores in the Mood, Stress, Nutrition and Hours Slept categories. Values between 1-3 in these areas could have an effect on your energy level.  You may even want to talk to your doctor if you consistently feel tired and weak.",
    @"If your Weather value is consistently between 1-3, you may have some strong feelings about what type of weather you like and feel most comfortable with.  Compare how you feel about the weather to some of the other values such as Mood and Energy. Charting your feelings about the weather can heighten your awareness of how it affects you, which could allow you to prepare yourself for those less than desirable days.",
    @"If you consistently sleep between 1-6 hours, you may be short on sleep and may have some mental or physical symptoms related to this lack of sleep.  Look at the days you sleep 1-6 hours and see if there is any correlation with your scores for Mood, Stress, Energy, Today and Tomorrow.  If you have between 1-6 hours frequently, or find it difficult to sleep, you may want to talk to your doctor."
};

NSString* const kWellbeingSpecificMidInfoText[WELLBEING_MINIMUM_COUNT] = {
    @"If your Yesterday value is consistently between 4-6, you may be having average days.  Take a moment to look at what went wrong and what went right.  There may be room for improvement here.  Use the Personal Chart to monitor an activity or behavior that makes you happy or an activity or behavior that caused you trouble. You may start to feel better about your day simply by monitoring it. It will heighten your awareness of how things impact you, which will help you cope.",
    @"If your Today values are consistently between 4-6, you may be regularly having average days. Try to plan something special for each day, even if it’s something small.  Use the Personal Chart to monitor when you plan a special activity and see if this correlates to a higher Today values.  Pay close attention to the other Charts in this app.  Score between 1-3 indicate a potential problem in those areas.",
    @"If your Tomorrow value is consistently between 4-6, you may be coping with your days but not expecting anything particularly positive or fun to happen. You can use the Personal Chart to monitor the frequency of an activity you like or that you don’t like and see if planning for this activity (or avoiding it) improves your outlook.  Pay close attention to the other charts in this app.  If you are finding scores between 1-3 this could indicate an area that is causing you trouble.",
    @"If your Energy value is consistently between 4-6, spend a moment to think about what may be causing you to feel a little tired.  Take a look at your Stress, Mood, Nutrition, Weather and Hours Slept values.  Scores between 1-3 in these areas could indicate a source for feeling less than energetic.",
    @"If your Weather value is consistently between 4-6, it is possible the weather is not having a negative affect on you, but may not be having a positive affect on you either.",
    @"If you consistently sleep between 1-6 hours, you may be short on sleep and may have some mental or physical symptoms related to this lack of sleep.  Look at the days you sleep 1-6 hours and see if there is any correlation with your scores for Mood, Stress, Energy, Today and Tomorrow.  If you have between 1-6 hours frequently, or find it difficult to sleep, you may want to talk to your doctor."
};

NSString* const kWellbeingSpecificHighInfoText[WELLBEING_MINIMUM_COUNT] = {
    @"If your Yesterday value is between 7-10, you may be having great days!  Take a moment to think about what experiences you had that attributed to this positive feeling about your day.  Reflecting on these feelings can help you make better choices.",
    @"If your Today value is consistently between 7-10, you may be regularly having good days. Take a moment to think about what attributed to these positive feelings about each day.  Acknowledging the things we enjoy can help contribute to a general feeling of well being when we reflect on them or try to plan for them in the future.",
    @"If your Tomorrow value is consistently between 7-10, then you may be regularly looking forward to, or being positive about, the future.  Positive thinking can help you cope with stress and give you a general feeling of wellbeing. Take a minute to think about what makes you happy and continue to incorporate these behaviors, activities and interactions in your life.",
    @"If your Energy value is consistently between 7-10, than you should be enjoying a reasonable amount of energy.  Feeling like you have energy can have strong, positive impact on your Mood and feelings of general wellbeing.",
    @"If your Weather value is consistently between 7-10, you may have strong, positive feelings about the weather.  Let it work for you.  If you notice certain days you rate your feelings about the weather in the 7-10 range, try to spend some time enjoying it.  If it’s a pleasant day and you have work, try having lunch outside.  If you like thunderstorms try to find a few minutes to sit and listen to the rain.",
    @"If you consistently sleep between 7-10 hours, this is generally considered in the range of a good night’s sleep. Eight hours is often considered ideal for many people.  Sleep is important to your health and mental state.  Try to continue to maintain a healthy amount of sleep each night and you can always ask your doctor what is the optimal number of hours for you."
};

NSString* const kLifestyleSpecificLowInfoText[LIFESTYLE_MINIMUM_COUNT] = {
    @"If your Stress value is consistently 1-3 you may perceive yourself as someone who is very stressed. You are likely to feel overwhelmed and have a pessimistic view. Stress can be debilitating.  The good news is you already started to help yourself.  Your value of 1-3 is a signal for you to spend some time evaluating what specifically in your life is causing stress. Write it down.  Pay close attention to the other charts in this app. Are your values for Nutrition, Social Life, Romantic Life and Hours Slept consistently in the 1-3 range as well?  If yes, these aspects of your life may be contributing to your level of stress. Find solutions to what is causing you to feel stressed. This app will help you monitor the key areas mentioned above. In the Personal Section, write in something that’s causing you stress.  Monitoring your stressors will help heighten your awareness.  Acknowledging what is bothering you is the first step to feeling better.",
    @"If your Mood value is consistently between 1-3, meaning you’re experiencing a sad or depressed mood, it could be very beneficial to monitor your mood using the chart in this app.  Long term feelings of sadness and depression can cause problems in your day-to-day functioning in work and with you social life.  There are professionals that can help you if you find you score yourself in the 1-3 range for weeks on end. Consider speaking to your doctor. This app can help you monitor several important areas that may be contributing to your mood such as Stress, Fitness, Social Life, Hours Slept, and how you feel about Today.  In the Personal Section, make sure you track something that is important to you.  Charting how you feel about things can help lift your mood because you are sending yourself a signal that you care enough to pay attention to things that affect you.",
    @"If your Fitness value is consistently between 1-3, “get moving!”  Really.  A little exercise is important. Take a close look at your scores on the other charts.  If you are finding scores between 1-3 on Stress, Mood, Energy, even Romantic Life, exercise could help you improve your scores in all of these areas.  Think about what activities you enjoy doing: walking, running, ping-pong, swimming, tennis.",
    @"If your Nutrition value is consistently between 1-3, you may be acknowledging that you do not have a very good diet.  Pay close attention to the charts in this app. for Mood, Energy, Today, Tomorrow, and even Hours Slept.  If you are finding values between 1-3 in these categories, poor nutrition could be having an impact on them. Write down everything you notice that is causing this low score and see where you can substitute better nutritional choices.  If you snack at home, replace the junk food with healthy snacks.  If fast food is the culprit try to put together some easily prepared meals and take them with you.  Plan your food for the day. Explore new foods that are considered healthy choices.",
    @"If your Social Life value is consistently between 1-3, you may not be satisfied with your interactions with other people. Are you feeling lonely or isolated?  Are you spending too much time at work to enjoy a healthy social life, or are you feeling depressed and unable to meet other people?  It may be beneficial for you to follow your charts on Mood, Today, Tomorrow, Energy, and Romantic Life. Are you finding values of 1-3 in these areas as well?  This would indicate where some of the problems may lie.  It is important to feel good about your social life. Help yourself by planning an enjoyable activity that will put you in contact with other people. Use the Personal Chart to monitor an activity that you would find beneficial to your social life.",
    @"If your Romantic Life value is between 1-3, you may have just broken up with someone, wish you had someone, or are having trouble in an existing relationship. Pay close attention to all the other charts in this app.  If you are finding scores in the range of 1-3 for other categories, they could stem from your low score in this category. Our relationships with someone significant can have a great effect on how we function and how we perceive things. Monitor this chart closely. If you are in a relationship and you consistently give yourself scores in the 1-3 range, you may want to look into talking about it with your significant other or seeking the help of a counselor. If you gave yourself a low score because you want a romantic life but do not have one, see how your score compares on the Social Life chart.  You may be able to meet someone special by engaging in more activates that put you in contact with other people.",
};

NSString* const kLifestyleSpecificMidInfoText[LIFESTYLE_MINIMUM_COUNT] = {
    @"If your Stress value consistently falls in the 4-6 range, you are coping with your day-to-day life but your perception of your stress level could be having a negative effect on you.  You may find yourself feeling edgy or maybe you have a nervous habit like biting your nails. Pay attention to the other charts particularly Nutrition, Social Life, Romantic Life and Hours Slept.  If any of these score are between 1-3 they could be contributing to your level of stress.  If there’s something bothering you lately, use the Personal Chart to track it.  Monitoring something will help you be aware of what is bothering you.  This is the first step to finding a solution.",
    @"If your Mood value is consistently between 4-6, you may be hanging in there but you could benefit from feeling “happier.”  A 4-6 range once in a while is normal.  Maybe you had a bad day at work or a fight with a friend.  Pay close attention to your chart overtime.  Write a list of activities that help lift your mood and try to incorporate them in your daily life.  Use the Personal Chart to keep track of an activity you enjoy doing and see if your score for Mood rises when you increase this and other activities you enjoy.",
    @"If your Fitness value is consistently between 4-6, you may be sensing that a little more physical activity in your day would be beneficial.  Think about what you are doing now for physical activity.  Is it something you can do more of?  Maybe you can only go to the gym three times a week and would benefit from an exercise routine you can do at home, too.  Try writing your planned method of exercise in the Personal Chart.  Now you can keep track of it!",
    @"If your Nutrition value is consistently between 4-6, this app can be very helpful in monitoring your eating habits.  How we eat effects how we handle things. Take a close look at your Mood, Energy, Today, and Tomorrow values.  If you are finding scores between 1-3, what you’re eating may be having a negative impact on you. Write down what you are eating and see where you can make better choices in the future.  Planning what you are going to eat for the day can help.",
    @"If your Social Life value is consistently between 4-6, you may be able to improve this score by planning an activity that will get you in contact with people you like being with or new people that share similar interests.  Your score may indicate that your social life is okay but you want more. What activities or clubs are in your area?  Set aside some time for something that will help you interact with others.",
    @"If your Romantic Life value is consistently between 4-6, you may be either moderately happy with your significant other, ending a relationship that you were ready to end, or maybe you’re newly seeking someone special.  Communication is one of the biggest problems couples have. If you’re single, than not having the opportunity to meet someone could be the problem. Spend some time analyzing specific things that are contributing to this score.  Now, think of something that would help the situation and use the Personal Chart to monitor how often you can engage in this helpful behavior.",
};

NSString* const kLifestyleSpecificHighInfoText[LIFESTYLE_MINIMUM_COUNT] = {
    @"If your Stress value is consistently between 7-10, it’s very possible the amount of stress you perceive in your life is actually helping you. Stress can help you pay attention to important issues and keep you alert about important matters. It’s okay to be a little stressed.  Pay close attention to your scores on the other charts.  If you find you have scores between 1-3, this may be contributing to your perception of your stress and you may want to look into how you can better cope in these areas.",
    @"If your Mood value is consistently between 7-10, in general you should be feeling good.  Keep it up!  Take a moment to think about all the things you are doing that bring you “happiness” and strive to keep them in your life.",
    @"If your Fitness value is consistently between 7-10, you are most likely engaged in a healthy amount of physical activity and hopefully are enjoying some benefits of exercise. It can help improve your mood, cope with stress, and keep you in good shape.  Would you say you are engaged in some form of physical activity every day?  If yes, then use the chart to see if you can continue this positive routine.",
    @"If your Nutrition value is consistently between 7-10, you most likely feel good about what you are eating.  Keep it up.  Good nutrition is very important for our physical and mental health.",
    @"If your Social Life value is consistently between 7-10, you may be reasonably happy with your friends, associates, and social activities.  Keep it up!  It’s important to enjoy the company of others whether it’s one close friend or a group of people.",
    @"If your Romantic Life value is consistently between 7-10, you are most likely happy with your partner or are single and not looking for a significant other. Feeling good about this aspect of your life can help elevate your Mood, increase your Energy, and relieve Stress."
};

@interface FeelingInfoViewController ()

@end

@implementation FeelingInfoViewController
@synthesize infoText = _infoText;
@synthesize infoTextView = _infoTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.infoTextView setText:self.infoText];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cloth"]]];
}

@end
