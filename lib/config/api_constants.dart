class ApiConstants {
  static String baseUrl = 'http://10.0.2.2:1337/api';

  // endpoints:
  static String usersEndpoint = '/users';
  static String registerEndpoint = '/auth/local/register';
  static String authEndpoint = '/auth/local';
  static String announcementsEndpoint = '/announcements';
  static String medicationsEndpoint = '/medications';
  static String medicationRemindersEndpoint = '/medication-reminders';
  static String messagesEndpoint = '/messages';
  static String postsEndpoint = '/posts';
  static String postLikesEndpoint = '/post-likes';
  static String stepCountersEndpoint = '/step-counters';
}