import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int _step = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _pregnancyWeekController = TextEditingController();

  List<String> _selectedSupplements = [];
  List<Map<String, dynamic>> _supplements = [
    {'name': '엽산', 'value': false},
    {'name': '칼슘', 'value': false},
    {'name': '철분', 'value': false},
    {'name': '비타민D', 'value': false},
    {'name': '오메가3', 'value': false},
  ];

  List<String> _selectedAllergies = [];
  List<Map<String, dynamic>> _allergies = [
    {'name': '어류', 'value': false},
    {'name': '유제품', 'value': false},
    {'name': '해당사항 없음', 'value': false},
  ];

  List<String> _selectedChronicDiseases = [];
  List<Map<String, dynamic>> _chronicDiseases = [
    {'name': '당뇨', 'value': false},
    {'name': '고혈압', 'value': false},
    {'name': '심장병', 'value': false},
    {'name': '비만', 'value': false},
    {'name': '간경화', 'value': false},
    {'name': '류마티스 관절염', 'value': false},
    {'name': '심장질환', 'value': false},
  ];

  List<String> _selectedHealthConcerns = [];
  List<Map<String, dynamic>> _healthConcerns = [
    {'name': '장 건강', 'value': false},
    {'name': '눈 건강', 'value': false},
    {'name': '피부', 'value': false},
    {'name': '피로감', 'value': false},
    {'name': '심장질환', 'value': false},
    {'name': '근육 경련', 'value': false},
  ];

  List<String> _selectedInvestment = [];

  List<Map<String, dynamic>> _investments = [
    {'name': '1500원', 'value': '1500'},
    {'name': '2500원', 'value': '2500'},
    {'name': '4500원', 'value': '4500'},
    {'name': '금액 상관없어요', 'value': 'none'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _pregnancyWeekController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _nextStep() {
    if (_step == 1 && _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('이름을 입력해주세요.'),
      ));
      return;
    }
    if (_step == 2 && _birthDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('생년월일을 입력해주세요.'),
      ));
      return;
    }
    if (_step == 3 && _heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('키를 입력해주세요.'),
      ));
      return;
    }
    if (_step == 4 && _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('임신 전 몸무게를 입력해주세요.'),
      ));
      return;
    }
    if (_step == 5 && _pregnancyWeekController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('임신 몇 주차이신가요?'),
      ));
      return;
    }
    if (_step == 9 && _selectedHealthConcerns.length > 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('건강고민은 최대 세 가지까지만 선택해주세요.'),
      ));
      return;
    }

  setState(() {
    if (_step < 10) {
      // 마지막 단계(10단계)에 도달할 때까지 단계 증가
      _step++;
    } else if (_step == 10) {
      // 10단계에서 '제출' 버튼을 누르면 설문 결과 출력
      print('Form submitted: Name: ${_nameController.text}, BirthDate: ${_birthDateController.text}, Height: ${_heightController.text}, Weight: ${_weightController.text}, Pregnancy Week: ${_pregnancyWeekController.text}, Supplements: $_selectedSupplements, Allergies: $_selectedAllergies, Chronic Diseases: $_selectedChronicDiseases, Health Concerns: $_selectedHealthConcerns, Investment: $_selectedInvestment');
      // 11단계로 이동
      _step = 11;
    } else if (_step == 11) {
      // 11단계 이후 초기화 및 첫 단계로 돌아감
      _step = 0;
      _selectedSupplements.clear();
      _selectedAllergies.clear();
      _selectedChronicDiseases.clear();
      _selectedHealthConcerns.clear();
      _selectedInvestment = [];
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

Text(
  _step == 0
      ? '맞춤 영양제를\n구성해드릴게요.'
      : _step == 1
          ? '성함을 입력해주세요.'
          : _step == 2
              ? '임산부의 생년월일을 입력해주세요.'
              : _step == 3
                  ? '키를 입력해주세요.'
                  : _step == 4
                      ? '임신 전 몸무게를 입력해주세요.'
                      : _step == 5 
                          ? '임신 몇 주차이신가요?'
                          : _step == 6
                              ? '드시고 있는 영양제가 있나요?'
                              : _step == 7
                                ? '어류나 유제품에 대한 알러지가 있나요?'
                                : _step == 8
                                  ? '지병이나 만성질환이 있나요?'
                                  : _step == 9
                                    ? '가장 큰 건강고민을\n세 가지까지 골라주세요.'
                                    : _step == 10
                                      ? '나의 건강에 매일 얼마까지 투자할 수 있나요?' 
                                      : '', // 기본 메시지
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),

            SizedBox(height: 20),
            if (_step > 0 && _step < 6)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: _step == 1 
                  ? TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '이름',
                      ),
                      keyboardType: TextInputType.name,
                    ) 
                  : _step == 2 
                    ? InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextField(
                            controller: _birthDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '생년월일',
                              hintText: 'YYYY-MM-DD',
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ) 
                    : _step == 3
                      ? TextField(
                          controller: _heightController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '키',
                            hintText: 'cm',
                          ),
                          keyboardType: TextInputType.number,
                        )
                      : _step == 4
                        ? TextField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '임신 전 몸무게',
                              hintText: 'kg',
                            ),
                            keyboardType: TextInputType.number,
                          )
                        : TextField(
                            controller: _pregnancyWeekController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '임신 주차',
                              hintText: '주',
                            ),
                            keyboardType: TextInputType.number,
                          ),
              ),
            if (_step == 6)
              ..._supplements.map((supplement) {
                return CheckboxListTile(
                  title: Text(supplement['name']),
                  value: supplement['value'],
                  onChanged: (bool? newValue) {
                    setState(() {
                      supplement['value'] = newValue!;
                      if (newValue) {
                        _selectedSupplements.add(supplement['name']);
                      } else {
                        _selectedSupplements.remove(supplement['name']);
                      }
                    });
                  },
                );
              }).toList(),
            if (_step == 7)
              ..._allergies.map((allergy) {
                return CheckboxListTile(
                  title: Text(allergy['name']),
                  value: allergy['value'],
                  onChanged: (bool? newValue) {
                    setState(() {
                      allergy['value'] = newValue!;
                      if (newValue) {
                        _selectedAllergies.add(allergy['name']);
                      } else {
                        _selectedAllergies.remove(allergy['name']);
                      }
                    });
                  },
                );
              }).toList(),
            if (_step == 8) 
              ..._chronicDiseases.map((disease) {
                return CheckboxListTile(
                  title: Text(disease['name']),
                  value: disease['value'],
                  onChanged: (bool? newValue) {
                    setState(() {
                      disease['value'] = newValue!;
                      if (newValue) {
                        _selectedChronicDiseases.add(disease['name']);
                      } else {
                        _selectedChronicDiseases.remove(disease['name']);
                      }
                    });
                  },
                );
              }).toList(),
            if (_step == 9)
              Column(
                children: [
                  ..._healthConcerns.map((concern) {
                    return CheckboxListTile(
                      title: Text(concern['name']),
                      value: concern['value'],
                      onChanged: (_selectedHealthConcerns.length < 3 || concern['value']) ? (bool? newValue) {
                        setState(() {
                          concern['value'] = newValue!;
                          if (newValue) {
                            _selectedHealthConcerns.add(concern['name']);
                          } else {
                            _selectedHealthConcerns.remove(concern['name']);
                          }
                        });
                      } : null,
                    );
                  }).toList(),
                ],
              ),
            if (_step == 10)
              Column(
                children: [
                  Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._investments.map((investment) {
                    return CheckboxListTile(
                      title: Text(investment['name']),
                      value: _selectedInvestment.contains(investment['value']),
                      onChanged: (bool? newValue) {
                        setState(() {
                          if (newValue!) {
                            _selectedInvestment.clear();
                            _selectedInvestment.add(investment['value']);
                          } else {
                            _selectedInvestment.removeWhere((element) => element == investment['value']);
                          }
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
              if (_step == 11) 
  Text(
    '맞춤 영양제를 구성 중입니다...',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),


            SizedBox(height: 20),
ElevatedButton(
  onPressed: _nextStep,
  child: Text(
    _step < 10 ? '다음' : (_step == 10 ? '제출' : '결과보기'), // 10단계에서 '제출' 표시
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
  ),
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 255, 183, 0),
    onPrimary: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  ),
),
          ],
        ),
      ),
    );
  }
}
