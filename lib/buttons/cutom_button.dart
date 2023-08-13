import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetris_game/providers/individual_provider.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final List<double> buttonSize;
  final List<Color> colors;
  final String? buttonName;
  final Color? textColor;

  final String type;
  final bool hasSound;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonSize,
    required this.colors,
    this.buttonName,
    this.textColor,
    this.type = 'tiny',
    this.hasSound = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    AudioPlayer().dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonhasSound = AudioPlayer();
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: widget.buttonSize[0],
              width: widget.buttonSize[0],
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    blurRadius: 8,
                    blurStyle: BlurStyle.inner,
                    offset: Offset(-6, -6),
                    inset: true,
                  ),
                  BoxShadow(
                      color: Color.fromARGB(255, 49, 15, 8),
                      blurRadius: 8,
                      blurStyle: BlurStyle.outer,
                      offset: Offset(6, 6),
                      inset: true),
                ],
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () {
                  if (!ref.watch(disableButtonProvider)) {
                    widget.onPressed();

                    if (ref.watch(soundProvider)) {
                      !widget.hasSound
                          ? widget.type == 'main'
                              ? buttonhasSound.play(AssetSource('click.wav'))
                              : buttonhasSound.play(
                                  AssetSource('cw_sound29.wav'),
                                  volume: 0.5)
                          : {};
                    }
                  }
                },
                onTapDown: (_) {
                  _controller.forward();
                },
                onTapUp: (_) {
                  _controller.reverse();
                },
                onTapCancel: () {
                  _controller.reverse();
                },
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: child,
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: widget.buttonSize[1],
                        width: widget.buttonSize[1],
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              widget.colors[2],
                              widget.colors[3],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.colors[4],
                              blurRadius: 4,
                              blurStyle: BlurStyle.inner,
                              offset: const Offset(4, 4),
                              inset: true,
                            ),
                            BoxShadow(
                              color: widget.colors[5],
                              blurRadius: 4,
                              blurStyle: BlurStyle.inner,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: widget.buttonSize[2],
                        width: widget.buttonSize[2],
                        decoration: BoxDecoration(
                          backgroundBlendMode: BlendMode.overlay,
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              widget.colors[0],
                              widget.colors[1],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        Visibility(
          visible: widget.buttonName != null,
          child: Padding(
            padding: EdgeInsets.only(top: widget.type == 'main' ? 5 : 0),
            child: Text(
              widget.buttonName ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.vt323(
                  color: widget.textColor,
                  fontSize: widget.type == 'main' ? 30 : 9,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
