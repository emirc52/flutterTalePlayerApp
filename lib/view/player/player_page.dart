import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tales/model/tale.dart';
import 'package:tales/modelview/player_model_view.dart';

class PlayerPage extends StatefulWidget {
  final Tale tale;
  PlayerPage(this.tale);
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Çalınıyor",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Theme.of(context).focusColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: taleMainField(),
          ),
          Expanded(
            flex: 2,
            child: playerActions(),
          )
        ],
      ),
    );
  }

  taleMainField() => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: taleCover(),
            ),
            Expanded(
              flex: 1,
              child: taleInformation(),
            )
          ],
        ),
      );

  taleCover() => Container(
        width: ScreenUtil().screenWidth,
        child: Hero(
          tag: widget.tale.taleID,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              widget.tale.taleProfileUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  taleInformation() => Container(
        width: ScreenUtil().screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              widget.tale.taleName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            AutoSizeText(
              widget.tale.voicingName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.overline,
            ),
          ],
        ),
      );

  playerActions() {
    bool isThisPlay = Provider.of<PlayerModelView>(context, listen: false)
        .isThisPlay(widget.tale);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: playerSlider(isThisPlay),
        ),
        Expanded(
          flex: 4,
          child: playerButtons(isThisPlay),
        ),
      ],
    );
  }

  Widget playerSlider(isThisPlay) {
    double taleLength = widget.tale.taleLength;
    final playerModelView = Provider.of<PlayerModelView>(context, listen: true);
    return StreamBuilder(
        stream: playerModelView.getDuration(),
        builder: (context, asyncSnapshot) {
          Duration duration = asyncSnapshot.data;
          if (playerModelView.setLastDuration(widget.tale) != null)
            duration = playerModelView.setLastDuration(widget.tale);
          else if (duration == null) duration = Duration.zero;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  duration.toString().substring(2, 7),
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.amber[700],
                        inactiveTrackColor: Colors.grey.withOpacity(0.6),
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        thumbColor: Colors.amber.shade700,
                        overlayColor: Colors.amber.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 20.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.amber[700],
                        inactiveTickMarkColor: Colors.amber[100],
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.amber.shade700,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: duration.inSeconds.toDouble(),
                        min: 0,
                        max: taleLength,
                        onChanged: (value) {
                          if (isThisPlay) {
                            playerModelView.seekTale(Duration(
                                minutes: value == 0 ? 0 : (value ~/ 60).toInt(),
                                seconds: (value % 60).toInt()));
                          } else {
                            playerModelView.playTale(widget.tale);
                            playerModelView.seekTale(Duration(
                                minutes: value == 0 ? 0 : (value ~/ 60).toInt(),
                                seconds: (value % 60).toInt()));
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  Duration(
                          minutes:
                              taleLength == 0 ? 0 : (taleLength ~/ 60).toInt(),
                          seconds: (taleLength % 60).toInt())
                      .toString()
                      .substring(2, 7),
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ],
            ),
          );
        });
  }

  playerButtons(isThisPlay) {
    final playerModelView =
        Provider.of<PlayerModelView>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pushReplacementNamed(
                '/playerPage',
                arguments: playerModelView.getPreviousTale(widget.tale.taleID)),
          ),
          GestureDetector(
              onTap: () async => await playAndPauseSound(widget.tale),
              child: CircleAvatar(
                  radius: 30.h,
                  backgroundColor: Theme.of(context).focusColor,
                  child: Icon(
                    isThisPlay ? Icons.pause : Icons.play_arrow,
                    size: 30.h,
                  ))),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () => Navigator.of(context).pushReplacementNamed(
                '/playerPage',
                arguments: playerModelView.getNextTale(widget.tale.taleID)),
          ),
        ],
      ),
    );
  }

  Future<void> playAndPauseSound(Tale tale) async =>
      await Provider.of<PlayerModelView>(context, listen: false)
          .playOrPauseSound(tale);
}
