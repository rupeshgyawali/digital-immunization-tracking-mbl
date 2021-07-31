import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/routes/router.dart';
import '../../models/child_model.dart';

class ChildrenList extends StatelessWidget {
  const ChildrenList({Key key, @required this.children, this.isEditable = true})
      : super(key: key);

  final List<Child> children;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children
              .map(
                (child) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePath.child_details,
                        arguments: ChildVaccineRecordRouteArgument(child,
                            isEditable: isEditable),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 10,
                              child: Text(
                                child.name?.substring(0, 1) ?? '',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 10 -
                                            20),
                              ),
                              foregroundImage: NetworkImage(
                                "${Config.storageUrl}/${child.photo ?? ' '}",
                              ),
                              onForegroundImageError: (obj, __) {
                                print(obj);
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            child.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.cake_outlined, size: 16),
                                        Expanded(
                                          child: Text(
                                            child.dob,
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.home_outlined, size: 16),
                                        Expanded(
                                          child: Text(
                                            child.temporaryAddr,
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.width / 5 - 10,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 50,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
