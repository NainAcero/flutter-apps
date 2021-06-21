import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  
  TextMessageModel({   
    required String senderName,
    required String sederUID,
    required String recipientName,
    required String recipientUID,
    required String messageType,
    required String message,
    required String messageId,
    required Timestamp time,
  }) : super(
    senderName:senderName,
    sederUID: sederUID,
    recipientName: recipientName,
    recipientUID: recipientUID,
    messsageType:messageType,
    message:message,
    messageId:messageId,
    time: time,
  );

  factory TextMessageModel.fromSnapShot(DocumentSnapshot snapshot){
    return TextMessageModel(
      senderName: snapshot.data()['senderName'],
      sederUID: snapshot.data()['sederUID'],
      recipientName: snapshot.data()['recipientName'],
      recipientUID: snapshot.data()['recipientUID'],
      messageType: snapshot.data()['messageType'],
      message: snapshot.data()['message'],
      messageId: snapshot.data()['messageId'],
      time: snapshot.data()['time'],
    );
  }

  Map<String,dynamic> toDocument(){
    return {
      "senderName":senderName,
      "sederUID":sederUID,
      "recipientName":recipientName,
      "recipientUID":recipientUID,
      "messageType":messsageType,
      "message":message,
      "messageId":messageId,
      "time":time,
    };
  }
}