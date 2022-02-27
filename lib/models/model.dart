import 'package:flutter/material.dart';

class ChatModel {
  String name, time, message, photo;

  ChatModel(
      {required this.name,
      required this.message,
      required this.photo,
      required this.time});
}

List<ChatModel> chatData = [
  ChatModel(
      name: 'مینا',
      message: 'سلام',
      photo:'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
      time: '16:30'),
  ChatModel(
      name: 'سمیه',
      message: 'چطوری؟',
      photo:'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300',
      time: '17:00'),
  ChatModel(
      name: 'میلاد',
      message: 'چیکار میکنی؟',
      photo:'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300',
      time: '10:24'),
  ChatModel(
      name: 'مامان',
      message: 'بیا خونه😂',
      photo:'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300',
      time: '23:10'),
  ChatModel(
      name: 'مریم',
      message: 'این ترم استاد داروهای گیاهی کیه؟',
      photo:'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300',
      time: '20:13'),

];
