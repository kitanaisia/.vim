#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import codecs

# 文字列出力時にencode("utf-8")して出力する
sys.stdout = codecs.getwriter("utf_8")(sys.stdout)
