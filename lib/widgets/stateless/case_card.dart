import 'package:flutter/material.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'package:vote4hk_mobile/models/case.dart';
import 'package:vote4hk_mobile/pages/case_detail_page.dart';
import 'package:vote4hk_mobile/widgets/stateless/link_button.dart';

import 'case_title.dart';

class CaseCard extends StatelessWidget {
  final Case data;

  CaseCard({this.data});

  @override
  Widget build(BuildContext context) {
    var subTextStyle = Theme.of(context).textTheme.caption;
    print('this');

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/case/detail', arguments: CreateDetailPageParam(caseNo: data.caseNo));        
      },
      child: Card(
          clipBehavior: Clip.hardEdge,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CaseTitle(
              caseNo: data.caseNo,
              status: data.statusEn,
              localizedStatus: data.localizedStatus(context) == '#N/A'
                  ? AppLocalizations.of(context).get('cases.uncategorized')
                  : data.localizedStatus(context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).getTemplate(
                          'dashboard.patient_age_format', {'age': data.age}) +
                      ' ' +
                      // TODO: extract this
                      (data.gender == 'M'
                          ? AppLocalizations.of(context)
                              .get('dashboard.gender_M')
                          : AppLocalizations.of(context)
                              .get('dashboard.gender_F'))),
                  SizedBox(height: 8.0),
                  // date
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .get('dashboard.patient_onset_date'),
                              style: subTextStyle),
                          Text(data.onSetDate ?? '')
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .get('dashboard.patient_confirm_date'),
                              style: subTextStyle),
                          Text(data.confirmationDate ?? '')
                        ],
                      ),
                    )
                  ]),
                  SizedBox(height: 8.0),
                  // hospital
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .get('dashboard.patient_hospital'),
                            style: subTextStyle,
                          ),
                          Text(data.localizedHospital(context) ?? '-')
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .get('dashboard.patient_citizenship'),
                              style: subTextStyle),
                          Text(data.localizedCitizenship(context) ?? '')
                        ],
                      ),
                    )
                  ]),
                  // Detail
                  if (data.localizedDetail(context) != '') ...[
                    Divider(),
                    SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.localizedDetail(context)),
                            if (data.sourceUrl != '') ...[
                              SizedBox(
                                height: 8,
                              ),
                              LinkButton(
                                text: AppLocalizations.of(context)
                                    .get('dashboard.source'),
                                url: data.sourceUrl,
                              )
                            ],
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                  // group
                  if (data.caseGroups.length > 0) ...[
                    Divider(),
                    Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .get('dashboard.group_name'),
                            style: subTextStyle,
                          ),
                          Text(data.localizedHospital(context) ?? '-')
                        ],
                      ),
                    ]),
                  ],

                  // Patient track
                  if (data.patientTrack.length > 0) ...[
                    Divider(),
                    SizedBox(
                      height: 8.0,
                    ),
                    ...data.patientTrack.map((t) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t.localizedAction(context),
                                  style: subTextStyle,
                                ),
                              ],
                            ),
                            Text(t.localizedLocation(context)),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              children: [
                                if (t.sourceUrl1 != '')
                                  LinkButton(
                                      url: t.sourceUrl1,
                                      text: AppLocalizations.of(context)
                                          .get('high_risk.source_1')),
                                if (t.sourceUrl2 != '') ...[
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  LinkButton(
                                      url: t.sourceUrl2,
                                      text: AppLocalizations.of(context)
                                          .get('high_risk.source_2'))
                                ],
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ))
                  ]
                ],
              ),
            ),
          ])),
    );
  }
}
