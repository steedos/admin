// Options
AccountsTemplates.configure({
  defaultLayout: 'loginLayout',
  // defaultLayoutRegions: {
  //   nav: 'nav',
  //   footer: 'footer',
  // },
  // defaultContentRegion: 'main',
  showForgotPasswordLink: true,
  overrideLoginErrors: true,
  enablePasswordChange: true,

  // sendVerificationEmail: true,
  // enforceEmailVerification: true,
  //confirmPassword: true,
  //continuousValidation: false,
  //displayFormLabels: true,
  //forbidClientAccountCreation: true,
  //formValidationFeedback: true,
  //homeRoutePath: '/',
  //showAddRemoveServices: false,
  //showPlaceholders: true,

  negativeValidation: true,
  positiveValidation: true,
  negativeFeedback: false,
  positiveFeedback: true,
  showLabels: false,

  // Privacy Policy and Terms of Use
  //privacyUrl: 'privacy',
  //termsUrl: 'terms-of-use',
});


if (Meteor.isClient){

  Router.configure({
      layoutTemplate: 'masterLayout',
      yieldTemplates: {
          loginNav: {to: 'nav'},
          loginFooter: {to: 'footer'},
      }
  });


  AccountsTemplates.configureRoute('changePwd');
  AccountsTemplates.configureRoute('forgotPwd');
  AccountsTemplates.configureRoute('resetPwd');
  AccountsTemplates.configureRoute('signIn');
  AccountsTemplates.configureRoute('signUp');
  AccountsTemplates.configureRoute('verifyEmail');
}