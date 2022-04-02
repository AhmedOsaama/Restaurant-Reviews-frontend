// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final name;
  final postcode;
  final photoUrl;
  final foodType;
  final date;
  final description;

  const RestaurantDetailScreen(
      {Key? key,
      this.name,
      this.postcode,
      this.photoUrl,
      this.foodType,
      this.date,
      this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(photoUrl),
              const SizedBox(
                height: 10,
              ),
              Text(name),
              const SizedBox(
                height: 10,
              ),
              Text(postcode),
              const SizedBox(
                height: 10,
              ),
              Text(foodType),
              const SizedBox(
                height: 10,
              ),
              Text("Created: ${DateFormat().add_yMMMd().format(DateTime.parse(date))}"),
              const SizedBox(
                height: 10,
              ),
              // MarkdownBody(data: description),
              Padding(
                padding: EdgeInsets.all(10),
                  child: MarkdownBody(data: description,
                    onTapLink:(text,href,title){
                      href != null ? launch(href) : null;
                    } ,),
//                 child: MarkdownBody(data: """
//  # Minimal Markdown Test
//  ---
//  This is a simple Markdown test. Provide a text string with Markdown tags
//  to the Markdown widget and it will display the formatted output in a
//  scrollable widget.
//
//  ## Section 1
//  Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
//  aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
//  eget est condimentum, vitae porttitor diam ornare.
//
//  ### Subsection A
//  Sed et massa finibus, blandit massa vel, vulputate velit. Vestibulum vitae
//  venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
//  accumsan ante.__** Sed a fermentum elit. Curabitur sodales metus id mi
//  ornare, in ullamcorper magna congue.
//  * item 1
//  * item 2
//  *This is italic text*
//
// _This is italic text_
//
// ~~Strikethrough~~
// ## Blockquotes
//
//
// > Blockquotes can also be nested...
// >> ...by using additional greater-than signs right next to each other...
// > > > ...or with spaces between arrows.
//
// 57. foo
// 1. bar
// 1. barrr
//
// ![Minion](https://octodex.github.com/images/minion.png)
//
// [link with title](http://nodeca.github.io/pica/demo/ "title text!")
//  """
//                     ,onTapLink: (text,href,title){
//                       href != null ? launch(href) : null;
//                   },
//                 ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
