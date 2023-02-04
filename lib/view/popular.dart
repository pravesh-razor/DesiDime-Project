import 'package:cached_network_image/cached_network_image.dart';
import 'package:desidime/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final _controller = Get.find<MyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 0
        ? const Center(child: Text("NO Connection"))
        : _controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return _controller.fetchPopulardeal();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _controller.scrollControllerpopular,
                        itemCount: _controller.populardeals[0].deals!.length,
                        itemBuilder: (context, index) => Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.15,
                                width: Get.width * 0.9,
                                child: Row(children: [
                                  CachedNetworkImage(
                                    imageUrl: _controller.populardeals[0]
                                        .deals![index].imageMedium
                                        .toString(),
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                    memCacheHeight: 100,
                                    memCacheWidth: 100,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("This is Hot Deal")
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.comment,
                                      size: 20,
                                    ),
                                    Text(_controller.populardeals[0]
                                        .deals![index].commentsCount
                                        .toString()),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_outlined,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(DateFormat('dd MMM yyyy').format(
                                            DateTime.parse(_controller
                                                .populardeals[0]
                                                .deals![index]
                                                .createdAt
                                                .toString())))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_controller.isLoad.value)
                      const Center(
                        child: LinearProgressIndicator(),
                      ),
                  ],
                ),
              ));
  }
}
