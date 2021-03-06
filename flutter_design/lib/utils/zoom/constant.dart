import 'package:flutter/material.dart';
import 'package:flutter_design/utils/zoom/colors.dart';
import 'package:flutter_icons/flutter_icons.dart';

List items = [
  {
    "title": "Start a Meeting",
    "description": "Start or join a video meeting onn the go",
    "img": "assets/zoom/slide_1.jpg"
  },
  {
    "title": "Share Your Content",
    "description": "They see what you see",
    "img": "assets/zoom/slide_2.jpg"
  },
  {
    "title": "Message Your Team",
    "description": "Send texts, voice messages, files and imagres",
    "img": "assets/zoom/slide_3.jpg"
  },
  {
    "title": "Get Zooming!",
    "description": "Work anywhere, with anyone, on any device",
    "img": "assets/zoom/slide_4.jpg"
  }
];

List participants = [
  {
    "img":
        "https://yt3.ggpht.com/yti/ANoDKi7t8UDpIBhR4vFhxH8woiUdojAZ-8kqhQKj3kki7g=s108-c-k-c0x00ffffff-no-rj",
    "name": "Sopheamen Van (Host)"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1496440737103-cd596325d314?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Valerie Elash"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1563306406-e66174fa3787?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Anne Peres"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Z2lybHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Gbarkz"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1567250671670-05e36d8ca38e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTZ8fHNlbGZpZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Askar Ulzhabayev"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1522602724102-7b966b111376?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=934&q=80",
    "name": "Quan Le"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1598966739654-5e9a252d8c32?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    "name": "Ali Kazal"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFjZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Houcine Ncib"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1557296387-5358ad7997bb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=994&q=80",
    "name": "Omid Armin"
  },
  
];

List bottomItems = [
  MaterialCommunityIcons.microphone,
  MaterialCommunityIcons.video,
  Ionicons.ios_share,
  Entypo.slideshare,
  Icons.more_horiz
];

List textItems = ["Mute", "Stop Video", "Share Screen", "Participants", "More"];

List colorItems = [ grey, grey, green, grey, grey, ];

List sizedItems = [ 30.0, 30.0, 30.0, 28.0, 30.0,];

List actionSheetItems = [
  "Raise Hand",
  "Chat",
  "Meeting Settings",
  "Minimize Meeting",
  "Virtual Background",
  "Disconnect Audio",
  "????   ????   ????   ????   ????   ????"
];