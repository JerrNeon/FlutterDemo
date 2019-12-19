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
  static const AssetImage ic_login_hello =
      AssetImage("images/ic_login_hello.png");
  static const AssetImage ic_login_btn = AssetImage("images/ic_login_btn.png");
  static const AssetImage bg_login = AssetImage("images/bg_login.png");
  static const AssetImage ic_login_back =
      AssetImage("images/ic_login_back.png");
  static const AssetImage ic_mine_book = AssetImage("images/ic_mine_book.png");
  static const AssetImage ic_mine_collection =
      AssetImage("images/ic_mine_collection.png");
  static const AssetImage ic_mine_course =
      AssetImage("images/ic_mine_course.png");
  static const AssetImage ic_mine_download =
      AssetImage("images/ic_mine_download.png");
  static const AssetImage ic_mine_edit = AssetImage("images/ic_mine_edit.png");
  static const AssetImage ic_mine_equity =
      AssetImage("images/ic_mine_equity.png");
  static const AssetImage ic_mine_focus =
      AssetImage("images/ic_mine_focus.png");
  static const AssetImage ic_mine_mall = AssetImage("images/ic_mine_mall.png");
  static const AssetImage ic_mine_message =
      AssetImage("images/ic_mine_message.png");
  static const AssetImage ic_mine_order =
      AssetImage("images/ic_mine_order.png");
  static const AssetImage ic_mine_point =
      AssetImage("images/ic_mine_point.png");
  static const AssetImage ic_mine_score =
      AssetImage("images/ic_mine_score.png");
  static const AssetImage ic_mine_set = AssetImage("images/ic_mine_set.png");
  static const AssetImage ic_mine_vip = AssetImage("images/ic_mine_vip.png");
  static const AssetImage ic_mine_arrow =
      AssetImage("images/ic_mine_arrow.png");
  static const AssetImage ic_mine_banner =
      AssetImage("images/ic_mine_banner.png");
  static const AssetImage ic_lecture_new =
      AssetImage("images/ic_lecture_new.png");
  static const AssetImage ic_consulation_ask =
      AssetImage("images/ic_consulation_ask.png");
  static const AssetImage ic_consulation_growth =
      AssetImage("images/ic_consulation_growth.png");
  static const AssetImage ic_consulation_vaccine =
      AssetImage("images/ic_consulation_vaccine.png");
  static const AssetImage ic_course_lock =
      AssetImage("images/ic_course_lock.png");
  static const AssetImage ic_course_play =
      AssetImage("images/ic_course_play.png");
  static const AssetImage ic_lecture_buy =
      AssetImage("images/ic_lecture_buy.png");
  static const AssetImage ic_lecture_comment_tag =
      AssetImage("images/ic_lecture_comment_tag.png");
  static const AssetImage ic_lecture_part =
      AssetImage("images/ic_lecture_part.png");
  static const AssetImage ic_lecture_tag =
      AssetImage("images/ic_lecture_tag.png");
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
    true: MyImages.ic_newdetail_audiopause,
    false: MyImages.ic_newdetail_audioplay,
  };

  static const course_status = <bool, AssetImage>{
    true: MyImages.ic_course_play,
    false: MyImages.ic_course_lock,
  };
}
