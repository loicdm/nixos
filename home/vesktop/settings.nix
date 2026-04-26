# modules/vesktop-settings.nix
{
  autoUpdate = true;
  autoUpdateNotification = true;
  notifyAboutUpdates = true;
  hardwareAcceleration = true;
  hardwareVideoAcceleration = true;

  plugins = {
    BadgeAPI.enabled = true;
    ChatInputButtonAPI.enabled = true;
    CommandsAPI.enabled = true;
    ContextMenuAPI.enabled = true;
    MemberListDecoratorsAPI.enabled = true;
    MessageAccessoriesAPI.enabled = true;
    MessageDecorationsAPI.enabled = true;
    MessageEventsAPI.enabled = true;
    NoticesAPI.enabled = true;
    ServerListAPI.enabled = true;

    NoTrack = {
      enabled = true;
      disableAnalytics = true;
    };

    Settings = {
      enabled = true;
      settingsLocation = "aboveActivity";
    };

    SupportHelper.enabled = true;

    BetterSettings = {
      enabled = true;
      disableFade = true;
      eagerLoad = true;
      organizeMenu = true;
    };

    BiggerStreamPreview.enabled = true;

    CallTimer = {
      enabled = true;
      format = "stopwatch";
    };

    ClearURLs.enabled = true;
    CrashHandler.enabled = true;

    FakeNitro = {
      enabled = true;
      enableStreamQualityBypass = false;
      transformCompoundSentence = true;
      emojiSize = 128;
      hyperLinkText = "{{NAME}}";
      useHyperLinks = true;
      disableEmbedPermissionCheck = true;
      stickerSize = 160;
    };

    FriendsSince.enabled = true;

    GameActivityToggle = {
      enabled = true;
      oldIcon = false;
      location = "PANEL";
    };

    MemberCount = {
      enabled = true;
      memberList = true;
      toolTip = true;
      voiceActivity = true;
    };

    MessageLogger = {
      enabled = true;
      deleteStyle = "text";
      ignoreBots = false;
      ignoreSelf = false;
      logEdits = true;
      logDeletes = true;
      collapseDeleted = false;
      inlineEdits = true;
    };

    petpet.enabled = true;
    PictureInPicture.enabled = true;

    PlatformIndicators = {
      enabled = true;
      colorMobileIndicator = true;
      list = true;
      badges = true;
      messages = true;
    };

    PreviewMessage.enabled = true;
    ReadAllNotificationsButton.enabled = true;

    ShowHiddenChannels = {
      enabled = true;
      showMode = 0;
      hideUnreads = true;
    };

    SilentTyping.enabled = true;

    TypingIndicator = {
      enabled = true;
      includeMutedChannels = false;
      includeCurrentChannel = true;
      indicatorMode = 3;
    };

    TypingTweaks = {
      enabled = true;
      alternativeFormatting = true;
    };

    VoiceChatDoubleClick.enabled = true;
    WebKeybinds.enabled = true;
    WhoReacted.enabled = true;
    VolumeBooster.enabled = true;
    ValidReply.enabled = true;
    WebScreenShareFixes.enabled = false;

    Summaries = {
      enabled = true;
      summaryExpiryThresholdDays = 3;
    };

    MessageUpdaterAPI.enabled = true;
    UserSettingsAPI.enabled = true;
    YoutubeAdblock.enabled = true;
    AccountPanelServerProfile.enabled = true;
    ExpressionCloner.enabled = true;
    DisableDeepLinks.enabled = true;
  };
}
