// Copyright (c) 2015, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library range_fix.example;

import 'dart:html';
import 'dart:math';

import 'package:color/color.dart';
import 'package:range_fix/range_fix.dart';

final Random randomGen = new Random();

String randomColor() {
  final r = randomGen.nextInt(256);
  final g = randomGen.nextInt(256);
  final b = randomGen.nextInt(256);
  return new RgbColor(r, g, b).toCssString();
}

void renderRects(List<Rectangle> rects) {
  for (final rect in rects) {
    final element = new DivElement();
    element.style
      ..backgroundColor = randomColor()
      ..opacity = '0.5'
      ..position = 'fixed'
      ..top = new Dimension.px(rect.top).toString()
      ..left = new Dimension.px(rect.left).toString()
      ..width = new Dimension.px(rect.width).toString()
      ..height = new Dimension.px(rect.height).toString();
    document.body.append(element);
  }
}

void main() {
  querySelector('#broken').innerHtml = '${isGetClientRectsBroken()}';

  final p1 = querySelector('#p1');
  final p2 = querySelector('#p2');
  final p3 = querySelector('#p3');
  final p4 = querySelector('#p4');

  final beforeRange = new Range()
    ..setStart(p1.firstChild, 3)
    ..setEnd(p2.firstChild, 3);

  final afterRange = new Range()
    ..setStart(p3.firstChild, 3)
    ..setEnd(p4.firstChild, 3);

  renderRects(beforeRange.getClientRects());
  renderRects(RangeFix.getClientRects(afterRange));
}
