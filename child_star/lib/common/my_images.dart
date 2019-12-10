import 'package:flutter/cupertino.dart';

class MyImages {
  static const AssetImage ic_home = AssetImage("images/ic_home.png");
  static const AssetImage ic_home_active =
      AssetImage("images/ic_home_active.png");
  static const AssetImage ic_knowledge = AssetImage("images/ic_knowledge.png");
  static const AssetImage ic_knowledge_active =
      AssetImage("images/ic_knowledge_active.png");
  static const AssetImage ic_exercise = AssetImage("images/ic_exercise.png");
  static const AssetImage ic_exercise_active =
      AssetImage("images/ic_exercise_active.png");
  static const AssetImage ic_consultation =
      AssetImage("images/ic_consultation.png");
  static const AssetImage ic_consultation_active =
      AssetImage("images/ic_consultation_active.png");
  static const AssetImage ic_home_message =
      AssetImage("images/3.0x/ic_home_message.png");
  static const AssetImage ic_home_personal =
      AssetImage("images/3.0x/ic_home_personal.png");
  static const AssetImage ic_home_search =
      AssetImage("images/3.0x/ic_home_search.png");
  static const AssetImage icon_home_tag =
      AssetImage("images/icon_home_tag.png");
  static const AssetImage icon_home_tagall =
      AssetImage("images/icon_home_tagall.png");
  static const AssetImage ic_homenew_audio =
      AssetImage("images/ic_homenew_audio.png");
  static const AssetImage ic_homenew_video =
      AssetImage("images/ic_homenew_video.png");
  static const AssetImage ic_homenew_look =
      AssetImage("images/ic_homenew_look.png");
  static const AssetImage ic_homenew_collect =
      AssetImage("images/ic_homenew_collect.png");
  static const AssetImage ic_homenew_uncollect =
      AssetImage("images/ic_homenew_uncollect.png");
  static const AssetImage ic_newdetail_authenticate =
      AssetImage("images/ic_newdetail_authenticate.png");
  static const AssetImage ic_newdetail_like =
      AssetImage("images/ic_newdetail_like.png");
  static const AssetImage ic_newdetail_collection =
      AssetImage("images/ic_newdetail_collection.png");
  static const AssetImage ic_newdetail_comment =
      AssetImage("images/ic_newdetail_comment.png");
  static const AssetImage ic_newdetail_download =
      AssetImage("images/ic_newdetail_download.png");
  static const AssetImage ic_newdetail_videoplay =
      AssetImage("images/ic_newdetail_videoplay.png");
  static const AssetImage ic_newdetail_audioplay =
      AssetImage("images/ic_newdetail_audioplay.png");
  static const AssetImage ic_newdetail_audiopause =
      AssetImage("images/ic_newdetail_audiopause.png");
  static const AssetImage ic_newdetail_audiowave =
      AssetImage("images/ic_newdetail_audiowave.png");
}

class MyImagesMultiple {
  static const home_media = <int, AssetImage>{
    1: MyImages.ic_homenew_video,
    2: MyImages.ic_homenew_audio,
  };
  static const home_collection = <bool, AssetImage>{
    true: MyImages.ic_homenew_collect,
    false: MyImages.ic_homenew_uncollect,
  };
  static const video_play = <bool, AssetImage>{
    true: MyImages.ic_newdetail_audiopause,
    false: MyImages.ic_newdetail_videoplay,
  };

  static const audio_play = <bool, AssetImage>{
    true: MyImages.ic_newdetail_audioplay,
    false: MyImages.ic_newdetail_audiopause,
  };
}
