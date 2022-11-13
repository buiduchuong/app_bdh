import 'package:design_flutter_ui_4/models/comment_models.dart';
import 'package:design_flutter_ui_4/models/message.dart';
import 'package:design_flutter_ui_4/models/models.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late User currentUserF;
final String urlIMG = "http://$IP/images/";

User currentUser = User(
  id: 0,
  truongHoc: "Nguyen Huu Tien",
  name: "Bui Duc Huong",
  quanHe: "Doc Than",
  songTai: "Ho Chi Minh",
  follows: 100,
  imageUrl:
      "https://danviet.mediacdn.vn/2020/10/27/2-16037897686341859390320.jpg",
);
// final List<Message> messages = [
//   Message(
//       "Con cac y",
//       "12/9",
//       User(
//         id: 2,
//         name: 'David Brooks',
//         imageUrl:
//             'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//       ),
//       1),
//   Message("Mai di choi khong", "21:09", onlineUsers[1], 1),
//   Message("Tra tao tien di", "11/08", onlineUsers[2], 2),
//   Message("Con me may", "22/01", onlineUsers[3], 3),
//   Message("Tao xin may", "11:29", onlineUsers[4], 4),
//   Message("Bo lay may", "22:09", onlineUsers[5], 5),
//   Message("Thang con cac", "19/12", onlineUsers[6], 6),
//   Message("u chiu", "12:00", onlineUsers[7], 7),
//   Message("thoi", "11/06", onlineUsers[8], 8),
//   Message("chiu thuc su", "22/12", onlineUsers[9], 9),
// ];

final List<User> onlineUsers = [
  User(
    id: 1,
    name: 'David Brooks',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 2,
    name: 'Jane Doe',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 3,
    name: 'Matthew Hinkle',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    id: 4,
    name: 'Amy Smith',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    id: 5,
    name: 'Ed Morris',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    id: 6,
    name: 'Carolyn Duncan',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 7,
    name: 'Paul Pinnock',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      id: 8,
      name: 'Elizabeth Wong',
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    id: 9,
    name: 'James Lathrop',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    id: 10,
    name: 'Jessie Samson',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 11,
    name: 'David Brooks',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 12,
    name: 'Jane Doe',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 13,
    name: 'Matthew Hinkle',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    id: 14,
    name: 'Amy Smith',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    id: 15,
    name: 'Ed Morris',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    id: 16,
    name: 'Carolyn Duncan',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 17,
    name: 'Paul Pinnock',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      id: 18,
      name: 'Elizabeth Wong',
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    id: 19,
    name: 'James Lathrop',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    id: 20,
    name: 'Jessie Samson',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

final List<Story> stories = [
  Story(
    id: 1,
    user: onlineUsers[2],
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  Story(
    id: 2,
    user: onlineUsers[6],
    imageUrl:
        'https://images.unsplash.com/photo-1499363536502-87642509e31b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    isViewed: true,
  ),
  Story(
    id: 3,
    user: onlineUsers[3],
    imageUrl:
        'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=624&q=80',
  ),
  Story(
    id: 4,
    user: onlineUsers[9],
    imageUrl:
        'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  Story(
    id: 5,
    user: onlineUsers[7],
    imageUrl:
        'https://images.unsplash.com/photo-1475688621402-4257c812d6db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
  ),
  Story(
    id: 6,
    user: onlineUsers[2],
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  Story(
    id: 7,
    user: onlineUsers[6],
    imageUrl:
        'https://images.unsplash.com/photo-1499363536502-87642509e31b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    isViewed: true,
  ),
  Story(
    id: 8,
    user: onlineUsers[3],
    imageUrl:
        'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=624&q=80',
  ),
  Story(
    id: 9,
    user: onlineUsers[9],
    imageUrl:
        'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  Story(
    id: 10,
    user: onlineUsers[7],
    imageUrl:
        'https://images.unsplash.com/photo-1475688621402-4257c812d6db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
  ),
];

// final List<Post> posts = [
//   Post(
//     id: 1,
//     user: currentUser,
//     caption: 'Check out these cool puppers',
//     timeAgo: 0,
//     imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8',
//     likes: 1202,
//     comments: 184,
//     shares: 96,
//     idPost: '633e49a35ee487064446379a',
//   ),
//   Post(
//     idPost: '633e49a35ee487064446379a',
//     id: 2,
//     user: onlineUsers[5],
//     caption:
//         'Please enjoy this placeholder text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//     timeAgo: 0,
//     imageUrl: "",
//     likes: 683,
//     comments: 79,
//     shares: 18,
//   ),
//   Post(
//     idPost: '633e49a35ee487064446379a',
//     id: 3,
//     user: onlineUsers[4],
//     caption: 'This is a very good boi.',
//     timeAgo: 0,
//     imageUrl:
//         'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//     likes: 894,
//     comments: 201,
//     shares: 27,
//   ),
//   Post(
//     idPost: '633e49a35ee487064446379a',
//     id: 4,
//     user: onlineUsers[3],
//     caption: 'Adventure 🏔',
//     timeAgo: 0,
//     imageUrl:
//         'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
//     likes: 722,
//     comments: 183,
//     shares: 42,
//   ),
//   Post(
//     id: 5,
//     user: onlineUsers[0],
//     caption:
//         'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//     timeAgo: 0,
//     imageUrl: '',
//     likes: 482,
//     comments: 37,
//     shares: 9,
//   ),
//   Post(
//     id: 6,
//     user: onlineUsers[9],
//     caption: 'A classic.',
//     timeAgo: 0,
//     imageUrl:
//         'https://images.unsplash.com/reserve/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//     likes: 1523,
//     shares: 129,
//     comments: 301,
//   )
// ];
// final List<Comment> cmts = [
//   Comment('VUi the', onlineUsers[1], 1),
//   Comment('Wow', onlineUsers[2], 2),
//   Comment('VUi the', onlineUsers[3], 3),
//   Comment('VUi the', onlineUsers[4], 4),
//   Comment('VUi the', onlineUsers[5], 5),
//   Comment('VUi tmmmmmmmmmmmmmmmmmmmmmmmmmhe', onlineUsers[6], 6),
//   Comment('VUi the', onlineUsers[7], 7),
//   Comment('VUi the', onlineUsers[8], 8)
// ];
// final int id;
// final int idGui;
// final int idNhan;
// final String noiDung;
// final bool isGui;
// final List<Inbox> chats = [
//   Inbox(1, 1, 1, 'hhaa', 1),
//   Inbox(1, 1, 2, 'hhaa', 0),
//   Inbox(1, 1, 2, 'hhaa', 1),
//   Inbox(
//       1,
//       7,
//       6,
//       'hdfdsgdsgdsfgdsgdsfgdsfgesrgesrgrsegsdggfhfghdfhgdfhhdfhsfafasdfafdhaa',
//       0),
//   Inbox(1, 4, 1, 'hhaa', 0),
//   Inbox(1, 6, 1, 'hhaa', 0),
//   Inbox(1, 8, 1, 'hhaa', 1),
//   Inbox(1, 8, 1, 'hhaa', 1),
//   Inbox(1, 8, 1, 'hhaa', 0),
// ];
const IP = 'huongnso.online';
  late  IO.Socket socket1 ;
String idUserCurrent = "";
String usernameUserCurrentToken = "";
final String avarUrlNull = "http://$IP/images/img-fb.jpg";
