import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/product/rrd-data.bloc.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/repository/instances/rrd-data.model.dart';
import 'package:maxcloud/screens/instance/components/line.chart.dart';
import 'package:maxcloud/utils/widgets.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../bloc/product/product.bloc.dart';
import 'package:intl/intl.dart';

class InstanceDetailScreen extends StatefulWidget {
  final InstanceData data;
  const InstanceDetailScreen({super.key, required this.data});

  @override
  State<InstanceDetailScreen> createState() => _InstanceDetailScreenState();
}

class _InstanceDetailScreenState extends State<InstanceDetailScreen> {
  List<ChartData>? chartData;
  List<ChartData> cpuData = [];
  List<ChartData> memoryData = [];
  List<ChartData> networkData = [];
  List<ChartData> diskData = [];

  int cpuPercentage = 0;
  int memoryPercentage = 0;
  int networkPercentage = 0;
  int diskPercentage = 0;

  String period = 'hour';

  Map rrdData = {
    "message": "RRD data",
    "data": {
      "cpu": [
        {"time": "2023-10-25 16:38", "cpu": 4.03},
        {"time": "2023-10-25 16:39", "cpu": 3.72},
        {"time": "2023-10-25 16:40", "cpu": 3.69},
        {"time": "2023-10-25 16:41", "cpu": 3.8},
        {"time": "2023-10-25 16:42", "cpu": 3.64},
        {"time": "2023-10-25 16:43", "cpu": 3.7},
        {"time": "2023-10-25 16:44", "cpu": 3.66},
        {"time": "2023-10-25 16:45", "cpu": 3.67},
        {"time": "2023-10-25 16:46", "cpu": 3.68},
        {"time": "2023-10-25 16:47", "cpu": 3.57},
        {"time": "2023-10-25 16:48", "cpu": 3.71},
        {"time": "2023-10-25 16:49", "cpu": 3.64},
        {"time": "2023-10-25 16:50", "cpu": 3.7},
        {"time": "2023-10-25 16:51", "cpu": 3.67},
        {"time": "2023-10-25 16:52", "cpu": 3.68},
        {"time": "2023-10-25 16:53", "cpu": 3.73},
        {"time": "2023-10-25 16:54", "cpu": 3.68},
        {"time": "2023-10-25 16:55", "cpu": 3.67},
        {"time": "2023-10-25 16:56", "cpu": 3.64},
        {"time": "2023-10-25 16:57", "cpu": 3.64},
        {"time": "2023-10-25 16:58", "cpu": 3.77},
        {"time": "2023-10-25 16:59", "cpu": 3.6},
        {"time": "2023-10-25 17:00", "cpu": 3.7},
        {"time": "2023-10-25 17:01", "cpu": 3.8},
        {"time": "2023-10-25 17:02", "cpu": 3.94},
        {"time": "2023-10-25 17:03", "cpu": 3.64},
        {"time": "2023-10-25 17:04", "cpu": 3.67},
        {"time": "2023-10-25 17:05", "cpu": 3.83},
        {"time": "2023-10-25 17:06", "cpu": 3.7},
        {"time": "2023-10-25 17:07", "cpu": 3.65},
        {"time": "2023-10-25 17:08", "cpu": 3.61},
        {"time": "2023-10-25 17:09", "cpu": 3.69},
        {"time": "2023-10-25 17:10", "cpu": 3.73},
        {"time": "2023-10-25 17:11", "cpu": 3.71},
        {"time": "2023-10-25 17:12", "cpu": 3.77},
        {"time": "2023-10-25 17:13", "cpu": 3.66},
        {"time": "2023-10-25 17:14", "cpu": 3.64},
        {"time": "2023-10-25 17:15", "cpu": 3.63},
        {"time": "2023-10-25 17:16", "cpu": 3.68},
        {"time": "2023-10-25 17:17", "cpu": 3.71},
        {"time": "2023-10-25 17:18", "cpu": 3.79},
        {"time": "2023-10-25 17:19", "cpu": 3.64},
        {"time": "2023-10-25 17:20", "cpu": 3.63},
        {"time": "2023-10-25 17:21", "cpu": 3.71},
        {"time": "2023-10-25 17:22", "cpu": 3.67},
        {"time": "2023-10-25 17:23", "cpu": 3.69},
        {"time": "2023-10-25 17:24", "cpu": 3.66},
        {"time": "2023-10-25 17:25", "cpu": 3.73},
        {"time": "2023-10-25 17:26", "cpu": 3.75},
        {"time": "2023-10-25 17:27", "cpu": 3.65},
        {"time": "2023-10-25 17:28", "cpu": 3.81},
        {"time": "2023-10-25 17:29", "cpu": 3.68},
        {"time": "2023-10-25 17:30", "cpu": 3.68},
        {"time": "2023-10-25 17:31", "cpu": 3.67},
        {"time": "2023-10-25 17:32", "cpu": 3.62},
        {"time": "2023-10-25 17:33", "cpu": 3.64},
        {"time": "2023-10-25 17:34", "cpu": 3.64},
        {"time": "2023-10-25 17:35", "cpu": 3.7},
        {"time": "2023-10-25 17:36", "cpu": 3.7},
        {"time": "2023-10-25 17:37", "cpu": 3.73},
        {"time": "2023-10-25 17:38", "cpu": 3.65},
        {"time": "2023-10-25 17:39", "cpu": 3.62},
        {"time": "2023-10-25 17:40", "cpu": 3.71},
        {"time": "2023-10-25 17:41", "cpu": 3.62},
        {"time": "2023-10-25 17:42", "cpu": 3.71},
        {"time": "2023-10-25 17:43", "cpu": 3.7},
        {"time": "2023-10-25 17:44", "cpu": 3.6},
        {"time": "2023-10-25 17:45", "cpu": 3.62},
        {"time": "2023-10-25 17:46", "cpu": 3.64},
        {"time": "2023-10-25 17:47", "cpu": 3.64}
      ],
      "memory": [
        {
          "time": "2023-10-25 16:38",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:39",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:40",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:41",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:42",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:43",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:44",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:45",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:46",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:47",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:48",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:49",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:50",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:51",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:52",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:53",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:54",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:55",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:56",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:57",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:58",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 16:59",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:00",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:01",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:02",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:03",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:04",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:05",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:06",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:07",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:08",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:09",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:10",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:11",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:12",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:13",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:14",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:15",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:16",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:17",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:18",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:19",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:20",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:21",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:22",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:23",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:24",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:25",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:26",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:27",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:28",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:29",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:30",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:31",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:32",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:33",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:34",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:35",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:36",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:37",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:38",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:39",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:40",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:41",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:42",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:43",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:44",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:45",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:46",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        },
        {
          "time": "2023-10-25 17:47",
          "raw_max_memory": 2.147,
          "max_memory": "2 GB",
          "raw_usage_memory": 1.173,
          "usage_memory": "1.17 GB"
        }
      ],
      "network": [
        {
          "time": "2023-10-25 16:38",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:39",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:40",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:41",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:42",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:43",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:44",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:45",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:46",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:47",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:48",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:49",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:50",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:51",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:52",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:53",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:54",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:55",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:56",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:57",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:58",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 16:59",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:00",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:01",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:02",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:03",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:04",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:05",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:06",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:07",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:08",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:09",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:10",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:11",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:12",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:13",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:14",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:15",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:16",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:17",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:18",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:19",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:20",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:21",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:22",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:23",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:24",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:25",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:26",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:27",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:28",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:29",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:30",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:31",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:32",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:33",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:34",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:35",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:36",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:37",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:38",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:39",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:40",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:41",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:42",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:43",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:44",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:45",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:46",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        },
        {
          "time": "2023-10-25 17:47",
          "raw_netin": 0,
          "netin": "0 b",
          "raw_netout": 0,
          "netout": "0 b"
        }
      ],
      "disk": [
        {
          "time": "2023-10-25 16:38",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:39",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:40",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:41",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:42",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:43",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:44",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:45",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:46",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:47",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:48",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:49",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:50",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:51",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:52",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:53",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:54",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:55",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:56",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:57",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:58",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 16:59",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:00",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:01",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:02",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:03",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:04",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:05",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:06",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:07",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:08",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:09",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:10",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:11",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:12",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:13",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:14",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:15",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:16",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:17",
          "raw_diskwrite": 0.002,
          "diskwrite": "1.96 Kb",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:18",
          "raw_diskwrite": 0.04,
          "diskwrite": "40.08 Kb",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:19",
          "raw_diskwrite": 0.001,
          "diskwrite": "544 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:20",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:21",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:22",
          "raw_diskwrite": 0.001,
          "diskwrite": "872 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:23",
          "raw_diskwrite": 0.002,
          "diskwrite": "1.86 Kb",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:24",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:25",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:26",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:27",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:28",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:29",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:30",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:31",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:32",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:33",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:34",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:35",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:36",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:37",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:38",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:39",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:40",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:41",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:42",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:43",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:44",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:45",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:46",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        },
        {
          "time": "2023-10-25 17:47",
          "raw_diskwrite": 0,
          "diskwrite": "0 b",
          "raw_diskread": 0,
          "diskread": "0 b"
        }
      ]
    }
  };

  final storage = new FlutterSecureStorage();

  ProductBloc? productBloc;
  RRDDataBloc? rrdDataBloc;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    rrdDataBloc = BlocProvider.of<RRDDataBloc>(context);
    getAccessToken();
    // fetchDataFromAPI();
    manipulateRRD();
    super.initState();
  }

  DateTime convertTimeStringToDateTime(String timeString) {
    return DateTime.parse(timeString);
  }

  void fetchDataFromAPI() {
    final data = rrdData;

    // Ambil data CPU
    if (data['data']['cpu'] != null) {
      final Map latestCpuData = data['data']['cpu'][0];
      final double percentage = latestCpuData['cpu'];
      cpuData = (data['data']['cpu'] as List).map((item) {
        return ChartData(
            convertTimeStringToDateTime(item['time']), item['cpu'].toDouble());
      }).toList();
      cpuPercentage = percentage.toInt();
    }

    // Ambil data Memory
    if (data['data']['memory'] != null) {
      final Map latestMemoryData = data['data']['memory'][0];
      final double maxMemory = latestMemoryData['raw_max_memory'];
      final double usageMemory = latestMemoryData['raw_usage_memory'];
      final double percentage = (usageMemory / maxMemory) * 100.0;

      memoryData = (data['data']['memory'] as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_usage_memory'].toDouble());
      }).toList();
      memoryPercentage = percentage.toInt();
    }

    // Ambil data Network
    if (data['data']['network'] != null) {
      networkData = (data['data']['network'] as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_netout'].toDouble());
      }).toList();
    }

    // Ambil data Disk
    if (data['data']['disk'] != null) {
      diskData = (data['data']['disk'] as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_diskread'].toDouble());
      }).toList();
    }

    setState(() {});
  }

  getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    productBloc?.add(FetchVMDetailEvent(accessToken ?? "", widget.data.uuid));
    rrdDataBloc
        ?.add(FetchRRDDataEvent(accessToken ?? "", widget.data.uuid, period));
  }

  manipulateRRD() async {
    final LoadedRRDDataState data =
        BlocProvider.of<RRDDataBloc>(context).state as LoadedRRDDataState;

    // Ambil data CPU
    if (data.rrdData.data?.cpu != null && data.rrdData.data?.cpu?.length != 0) {
      final Cpu? latestCpuData = data.rrdData.data?.cpu?[0];
      final double? percentage = latestCpuData?.cpu;
      cpuData = (data.rrdData.data?.cpu as List).map((item) {
        return ChartData(
            convertTimeStringToDateTime(item['time']), item['cpu'].toDouble());
      }).toList();
      cpuPercentage = percentage!.toInt();
    }

    // Ambil data Memory
    if (data.rrdData.data?.memory != null &&
        data.rrdData.data?.memory?.length != 0) {
      final Memory? latestMemoryData = data.rrdData.data?.memory?[0];
      final double? maxMemory = latestMemoryData?.rawMaxMemory;
      final double? usageMemory = latestMemoryData?.rawUsageMemory;
      final double percentage = (maxMemory! / usageMemory!) * 100.0;

      memoryData = (data.rrdData.data?.memory as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_usage_memory'].toDouble());
      }).toList();
      memoryPercentage = percentage.toInt();
    }

    // Ambil data Network
    if (data.rrdData.data?.network != null &&
        data.rrdData.data?.network?.length != 0) {
      networkData = (data.rrdData.data?.network as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_netout'].toDouble());
      }).toList();
    }

    // Ambil data Disk
    if (data.rrdData.data?.disk != null &&
        data.rrdData.data?.disk?.length != 0) {
      diskData = (data.rrdData.data?.disk as List).map((item) {
        return ChartData(convertTimeStringToDateTime(item['time']),
            item['raw_diskread'].toDouble());
      }).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Detail",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
              height: 24, fit: BoxFit.scaleDown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is LoadedVMDetailState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/icons/windows.png",
                            height: 48,
                          ),
                          SizedBox(width: 12),
                          Text(state.vmDetail.data?.hostname ?? "",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff009EFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),
                      Flexible(
                        flex: 3,
                        child: MaterialButton(
                          minWidth: 89.w,
                          height: 20.h,
                          elevation: 0,
                          color: Color(0xff02D430),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () {},
                          child: Text(
                            "●  ${state.vmDetail.data?.status ?? "-"}",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icons/monitor-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                      SizedBox(width: 15.w),
                      SvgPicture.asset('assets/svg/icons/power-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                      SizedBox(width: 15.w),
                      SvgPicture.asset('assets/svg/icons/reload-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                    ],
                  ),
                  Spacer(),
                  Flexible(
                    flex: 1,
                    child: MaterialButton(
                      height: 30.h,
                      elevation: 0,
                      color: Color(0xffF1F1F1),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xffBBBBBB)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hourly",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff232226),
                                    fontWeight: FontWeight.w600)),
                          ),
                          SvgPicture.asset('assets/svg/icons/dropdown.svg',
                              height: 15.h, fit: BoxFit.scaleDown),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                getGradientProgressStyle("CPU Usage", cpuPercentage.toDouble()),
                getGradientProgressStyle(
                    "Disk Operation", diskPercentage.toDouble())
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                getGradientProgressStyle(
                    "Network", networkPercentage.toDouble()),
                getGradientProgressStyle("Memory", memoryPercentage.toDouble())
              ]),
              SizedBox(height: 30),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is LoadedVMDetailState) {
                  return Column(
                    children: [
                      rowSpec("Location", state.vmDetail.data?.location ?? "-"),
                      rowSpec(
                          "IP Address", state.vmDetail.data?.ipAddress ?? "-"),
                      rowSpec("Username", state.vmDetail.data?.username ?? "-"),
                      rowSpec("Hostname", state.vmDetail.data?.hostname ?? "-"),
                      rowSpec("CPU", state.vmDetail.data?.cpu ?? "-"),
                      rowSpec("RAM", state.vmDetail.data?.memory ?? "-"),
                      rowSpec("Storage", state.vmDetail.data?.storage ?? "-"),
                      rowSpec("OS", state.vmDetail.data?.osName ?? "-"),
                      rowSpec("Price Per Hour",
                          "Rp ${state.vmDetail.data?.pricePerHour ?? 0}"),
                      rowSpec("Estimated Monthly Cost",
                          "Rp ${state.vmDetail.data?.estimatedMonthlyPrice ?? 0}"),
                      rowSpec("Private Network",
                          state.vmDetail.data?.privateNetwork ?? "-"),
                      rowSpec(
                          "Created at", state.vmDetail.data?.createdAt ?? "-"),
                      rowSpec("Last Started at",
                          state.vmDetail.data?.lastStartedAt ?? "-"),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: ScreenUtil().screenWidth,
                height: 250,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbbbbbb), width: 1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: CustomLineChart.buildDefaultLineChart(
                        'CPU Usage', cpuData)),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: ScreenUtil().screenWidth,
                height: 250,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbbbbbb), width: 1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: CustomLineChart.buildDefaultLineChart(
                        'Memory Usage', memoryData)),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: ScreenUtil().screenWidth,
                height: 250,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbbbbbb), width: 1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: CustomLineChart.buildDefaultLineChart(
                        'Network Usage', networkData)),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: ScreenUtil().screenWidth,
                height: 250,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbbbbbb), width: 1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: CustomLineChart.buildDefaultLineChart(
                        'Disk Usage', diskData)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }

  Widget rowSpec(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xffBBBBBB),
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Text(
              ":  $value",
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff232226),
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getGradientProgressStyle(String title, double percent) {
    return SizedBox(
        height: 160,
        width: 160,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: AxisLineStyle(
                thickness: 0.2,
                color: Colors.grey.shade200,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    cornerStyle: CornerStyle.bothCurve,
                    value: percent,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationType: AnimationType.linear,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFD0EDFF), Color(0xFF009EFF)],
                        stops: <double>[0.25, 0.75])),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0.1,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          percent.toStringAsFixed(0) + '%',
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff009EFF),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ))
              ]),
        ]));
  }
}
