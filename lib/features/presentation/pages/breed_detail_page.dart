import 'package:cat_breeds/features/presentation/widgets/info_item.dart';
import 'package:flutter/material.dart';
              import '../../data/datasources/cat_api_datasource.dart';

              class BreedDetailPage extends StatelessWidget {
                final String name;
                final String imageUrl;
                final String description;
                final String origin;
                final String temperament;
                final int intelligence;
                final int adaptability;
                final String lifeSpan;
                final String? referenceImageId;

                const BreedDetailPage({
                  super.key,
                  required this.name,
                  required this.imageUrl,
                  required this.description,
                  required this.origin,
                  required this.temperament,
                  required this.intelligence,
                  required this.adaptability,
                  required this.lifeSpan,
                  this.referenceImageId,
                });

                @override
                Widget build(BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(name,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    ),
                    body: Column(
                      children: [
                        if (referenceImageId != null)
                          FutureBuilder<String?>(
                            future: CatApiDatasource().fetchImageUrl(referenceImageId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  width: double.infinity,
                                  height: 220,
                                  color: Colors.grey[300],
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              } else if (snapshot.hasData && snapshot.data != null) {
                                return Image.network(
                                  snapshot.data!,
                                  width: double.infinity,
                                  height: 220,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  height: 220,
                                  color: Colors.grey[300],
                                  child: const Center(child: Icon(Icons.image_not_supported)),
                                );
                              }
                            },
                          )
                        else
                          Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoItemWidget(description: description,subTitle:'Descripción:' ),
                                const SizedBox(height: 16),
                                InfoItemWidget(description: origin,subTitle:'Origen :' ),
                                const SizedBox(height: 16),
                                InfoItemWidget(description: temperament,subTitle:'Temperamento:' ),
                                const SizedBox(height: 16),
                                InfoItemWidget(description: intelligence.toString(),subTitle:'Inteligencia:' ),
                                const SizedBox(height: 16),
                                InfoItemWidget(description: '$adaptability',subTitle:'Adaptabilidad:' ),
                                const SizedBox(height: 16),
                                InfoItemWidget(description: '$lifeSpan años',subTitle:'Esperanza de vida:' ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }