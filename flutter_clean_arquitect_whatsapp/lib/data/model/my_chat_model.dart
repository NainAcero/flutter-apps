
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  
  MyChatModel({
    required String senderName,
    required String senderUID,
    required String recipientName,
    required String recipientUID,
    required String channelId,
    required String profileURL,
    required String recipientPhoneNumber,
    required String senderPhoneNumber,
    required String recentTextMessage,
    required bool isRead,
    required bool isArchived,
    required Timestamp time,
  }) : super(
    senderName: senderName,
    senderUID: senderUID,
    recipientName: recipientName,
    recipientUID: recipientUID,
    channelId: channelId,
    profileURL: profileURL,
    recipientPhoneNumber: recipientPhoneNumber,
    senderPhoneNumber: senderPhoneNumber,
    recentTextMessage: recentTextMessage,
    isRead: isRead,
    isArchived: isArchived,
    time: time,
  );

  factory MyChatModel.fromSnapShot(DocumentSnapshot snapshot) {
    return MyChatModel(
      senderName: snapshot.data()['senderName'],
      senderUID: snapshot.data()['senderUID'],
      senderPhoneNumber: snapshot.data()['senderPhoneNumber'],
      recipientName: snapshot.data()['recipientName'],
      recipientUID: snapshot.data()['recipientUID'],
      recipientPhoneNumber: snapshot.data()['recipientPhoneNumber'],
      channelId: snapshot.data()['channelId'],
      time: snapshot.data()['time'],
      isArchived: snapshot.data()['isArchived'],
      isRead: snapshot.data()['isRead'],
      recentTextMessage: snapshot.data()['recentTextMessage'],
      profileURL: snapshot.data()['profileURL'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "channelId": channelId,
      "profileURL": profileURL,
      "recipientPhoneNumber": recipientPhoneNumber,
      "senderPhoneNumber": senderPhoneNumber,
      "recentTextMessage": recentTextMessage,
      "isRead": isRead,
      "isArchived": isArchived,
      "time": time,
    };
  }
}