import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Model/CoreResponseModel.dart';
import 'package:amor_93_7_fm/Model/PlaylistModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';

// ignore: must_be_immutable
class PlaylistDialog extends StatefulWidget {
  Function playListCallback;
  Function favCall;
  int isFav;
  bool isPlaylist;
  String playlistID;
  String songID;
  String playlistsong_id;
  PlaylistDialog(
      {Key key,
      this.playListCallback,
      this.favCall,
      this.isFav,
      this.isPlaylist,
      this.playlistID,
      this.playlistsong_id,
      this.songID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PlaylistDialogState();
  }
}

class PlaylistDialogState extends State<PlaylistDialog> {
  bool isLoader = false;

  void removeSongToPlaylist() async {
    var param = {
      // "playlist_id": widget.playlistID,
      "playlistsong_id": widget.playlistsong_id,
      "user_id": Constants.userModel.userId.toString(),
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model =
        await APIClient().addSongToPlaylist(param, "remove");
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context, appName, model.message, ok, () => {_removeSong()});
  }

  _removeSong() {
    Navigator.pop(context);
    widget.playListCallback();
  }

  addRemoveFavSongApi() async {
    var param = {
      "song_id": widget.songID,
      "user_id": Constants.userModel.userId.toString(),
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model = await APIClient().addRemoveFavSong(param);
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context, appName, model.message, ok, () => {updateRow()});
  }

  updateRow() {
    Navigator.pop(context);
    Future.delayed(Duration(milliseconds: 100), () => {widget.favCall()});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.black,
        content: Container(
          color: Colors.transparent,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Add Songs to Playlist or Favorites!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(
                height: 1,
                color: Colors.white,
              ),
              TextButton(
                  onPressed: () => {
                        if (widget.isPlaylist == true)
                          {removeSongToPlaylist()}
                        else
                          {widget.playListCallback()}
                      },
                  child: Text(
                    widget.isPlaylist == null || widget.isPlaylist == false
                        ? 'Add to Playlist'
                        : 'Remove to Playlist',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
              Divider(
                height: 1,
                color: Colors.white,
              ),
              TextButton(
                  onPressed: () =>
                      {widget.isFav == 0 ? updateRow() : addRemoveFavSongApi()},
                  child: Text(
                    'Add to Favorites!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ],
          ),
        ),
      ),
      isLoader ? progressView(context) : Container()
    ]);
  }
}

// ignore: must_be_immutable
class AddPlayListDialog extends StatefulWidget {
  Function createCallback;
  Function addExistingCallback;
  AddPlayListDialog({Key key, this.createCallback, this.addExistingCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new AddPlayListDialogState();
  }
}

class AddPlayListDialogState extends State<AddPlayListDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.black,
      content: Container(
        color: Colors.transparent,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'Create Playlist or Add to Existing!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            TextButton(
                onPressed: () => {widget.createCallback()},
                child: Text(
                  'Create Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            TextButton(
                onPressed: () => {widget.addExistingCallback()},
                child: Text(
                  'Add to Existing Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CreatePlayListDialog extends StatefulWidget {
  Function createCall;
  String songID;
  Function callBack;
  CreatePlayListDialog({Key key, this.callBack, this.createCall, this.songID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new CreatePlayListDialogState();
  }
}

class CreatePlayListDialogState extends State<CreatePlayListDialog> {
  String name = "";
  bool isLoader = false;

  _isValid() {
    String msg = "";
    if (name == "") {
      msg = enterPlaylistName;
    }
    if (msg.isEmpty) {
      // widget.createCall(name);
      createPlaylistAPI(
        name,
      );
      return;
    }
    Dialogs.showOSDialog(context, appName, msg, ok, () => {});
  }

  void createPlaylistAPI(String name) async {
    var param = {
      "name": name,
      "user_id": Constants.userModel.userId.toString()
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model =
        await APIClient().createRemovePlaylist(param, "add");
    // Navigator.pop(context);
    // setState(() {
    //   isLoader = false;
    // });
    if (model.status >= 200 && model.status <= 210) {
      addSongToPlaylist(model.playlist_id.toString());
    } else {
      Dialogs.showOSDialog(
          context,
          appName,
          model.message,
          ok,
          () => {
                setState(() {
                  isLoader = false;
                })
              });
    }
  }

  void addSongToPlaylist(String playlistID) async {
    var param = {
      "playlist_id": playlistID,
      "song_id": widget.songID,
      "user_id": Constants.userModel.userId.toString(),
    };
    // setState(() {
    //   isLoader = true;
    // });
    CoreResponseModel model = await APIClient().addSongToPlaylist(param, "add");
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context,
        appName,
        model.message,
        ok,
        () => {
              if (widget.callBack != null)
                {widget.callBack()}
              else
                {Navigator.pop(context)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.black,
        content: Container(
          color: Colors.transparent,
          height: 130,
          width: Utility(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  onChanged: (value) => {name = value},
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      isDense: true,
                      hintText: "Please Enter Playlist Name",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => {_isValid()},
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  Container(
                    color: Colors.white,
                    width: 1,
                    height: 51,
                  ),
                  TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      isLoader ? progressView(context) : Container()
    ]);
  }
}

// ignore: must_be_immutable
class ExistingPlayListDialog extends StatefulWidget {
  PlaylistModel playlistModel;
  String songID;
  Function callBack;

  ExistingPlayListDialog(
      {Key key, this.songID, this.playlistModel, this.callBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ExistingPlayListDialogState();
  }
}

class ExistingPlayListDialogState extends State<ExistingPlayListDialog> {
  bool isLoader = false;

  void addSongToPlaylist(String playlistID) async {
    var param = {
      "user_id": Constants.userModel.userId.toString(),
      "playlist_id": playlistID,
      "song_id": widget.songID
    };
    // setState(() {
    //   isLoader = true;
    // });
    CoreResponseModel model = await APIClient().addSongToPlaylist(param, "add");
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context,
        appName,
        model.message,
        ok,
        () => {
              if (widget.callBack != null)
                {widget.callBack()}
              else
                {Navigator.pop(context)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlaylistModel>(
        future: APIClient().getPlaylist(
            {"user_id": Constants.userModel.userId.toString()}, "1"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.status);
            if (snapshot.data.status == 200) {
              widget.playlistModel = snapshot.data;
              if (widget.playlistModel.data.length == 0 ||
                  widget.playlistModel.data.isEmpty) {
                // Dialogs.showOSDialog(
                //     context, appName, "No Playlist Found", ok, () {
                //   Navigator.pop(context);
                // });
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  title: Center(
                      child: Text(
                    "No Playlist found",
                  )),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ok,
                        style: TextStyle(fontSize: 15, color: appColor),
                      ),
                    )
                  ],
                  actionsPadding: EdgeInsets.only(right: 10, bottom: 10),
                );
              } else {
                return Stack(
                  children: [
                    AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      backgroundColor: Colors.black,
                      content: Container(
                        color: Colors.transparent,
                        height: 250,
                        width: Utility(context).width * 0.5,
                        child: ListView.builder(
                            itemCount: widget.playlistModel.data.length,
                            itemBuilder: (context, index) {
                              PlaylistData data =
                                  widget.playlistModel.data[index];
                              return InkWell(
                                onTap: () => {
                                  addSongToPlaylist(data.playlistId.toString())
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        data.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Text(
                snapshot.data.message,
                style: TextStyle(color: Colors.white),
              );
            }
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Text(
              "${snapshot.error}",
              style: TextStyle(color: Colors.white),
            );
          }
          // By default, show a loading spinner.
          return isLoader ? progressView(context) : Container();
        });
  }
}
