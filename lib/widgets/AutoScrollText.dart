import 'package:flutter/material.dart';

class SmartMarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  
  const SmartMarqueeText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 16),
  });

  @override
  // ignore: library_private_types_in_public_api
  _SmartMarqueeTextState createState() => _SmartMarqueeTextState();
}

class _SmartMarqueeTextState extends State<SmartMarqueeText> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isTextOverflowing = false;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
  }

  void _checkOverflow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final textSize = renderBox.size;
        final maxWidth = renderBox.constraints.maxWidth;
        
        final shouldScroll = textSize.width > maxWidth;
        
        if (shouldScroll != _isTextOverflowing) {
          setState(() {
            _isTextOverflowing = shouldScroll;
          });
          
          if (shouldScroll) {
            _controller.repeat();
          } else {
            _controller.stop();
            _controller.reset();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Измеряем текст
          WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
          
          return Stack(
            children: [
              // Измерительный текст (невидимый)
              Opacity(
                opacity: 0,
                child: Text(
                  widget.text,
                  key: _textKey,
                  style: widget.style,
                  maxLines: 1,
                ),
              ),
              // Отображаемый текст
              _buildDisplayText(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDisplayText() {
    if (!_isTextOverflowing) {
      return Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
        overflow: TextOverflow.clip,
      );
    }
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-_controller.value * 300, 0),
          child: Row(
            children: [
              Text(widget.text, style: widget.style),
              const SizedBox(width: 50),
              Text(widget.text, style: widget.style),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}