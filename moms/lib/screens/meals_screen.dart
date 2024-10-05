import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/homepage.dart';
import 'package:intl/intl.dart';
// import 'package:moms/screens/homepage.dart';

class MealPlanCalendar extends StatefulWidget {
  const MealPlanCalendar({Key? key}) : super(key: key);

  @override
  _MealPlanCalendarState createState() => _MealPlanCalendarState();
}

class _MealPlanCalendarState extends State<MealPlanCalendar> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  final List<String> _daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  final Map<String, List<String>> _mealPlans = {
    'breakfast': [
      "Whole grain toast with avocado and a boiled egg",
      "Greek yogurt with berries and granola",
      "Spinach and cheese omelet with whole wheat toast",
      "Oatmeal with sliced almonds and banana",
      "Whole grain pancakes with almond butter and strawberries",
      "Smoothie bowl with mixed fruits and chia seeds",
      "Whole grain cereal with milk and sliced peaches"
    ],
    'lunch': [
      "Grilled chicken salad with mixed greens and vinaigrette",
      "Lentil soup with whole grain crackers",
      "Tuna sandwich on whole wheat bread with carrot sticks",
      "Quinoa bowl with roasted vegetables and chickpeas",
      "Turkey and cheese wrap with apple slices",
      "Vegetable stir-fry with brown rice",
      "Baked sweet potato with black beans and salsa"
    ],
    'dinner': [
      "Grilled salmon with steamed broccoli and brown rice",
      "Lean beef stir-fry with mixed vegetables",
      "Baked chicken breast with roasted sweet potato and green beans",
      "Vegetarian chili with cornbread",
      "Whole wheat pasta with tomato sauce and lean ground turkey",
      "Baked cod with quinoa and roasted asparagus",
      "Lentil and vegetable curry with brown rice"
    ],
    'snacks': [
      "Apple slices with peanut butter",
      "Carrot sticks with hummus",
      "Greek yogurt with honey",
      "Handful of mixed nuts",
      "Whole grain crackers with cheese",
      "Sliced bell peppers with guacamole",
      "Banana with almond butter"
    ]
  };

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.purple,
              size: 34,
            )),
        title: const Text(
          'Meal Plan Calendar',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildMonthSelector(),
          _buildCalendarListView(),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _previousMonth,
          ),
          Text(
            DateFormat('MMMM yyyy').format(_currentMonth),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _daysInMonth,
        itemBuilder: (context, index) {
          return _buildDayCard(index + 1);
        },
      ),
    );
  }

  Widget _buildDayCard(int day) {
    DateTime cellDate = DateTime(_currentMonth.year, _currentMonth.month, day);
    bool isToday = cellDate.isAtSameMomentAs(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsScreen(
              date: cellDate,
              mealPlans: {
                'breakfast': _mealPlans['breakfast']![day % 7],
                'lunch': _mealPlans['lunch']![day % 7],
                'dinner': _mealPlans['dinner']![day % 7],
                'snacks': _mealPlans['snacks']![day % 7],
              },
            ),
          ),
        );
      },
      child: Card(
        color: isToday ? Colors.purple : Colors.white,
        child: ListTile(
          title: Text(
            'Day $day',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isToday ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMealText(
                  'Breakfast', _mealPlans['breakfast']![day % 7], isToday),
              _buildMealText('Lunch', _mealPlans['lunch']![day % 7], isToday),
              _buildMealText('Dinner', _mealPlans['dinner']![day % 7], isToday),
              _buildMealText('Snack', _mealPlans['snacks']![day % 7], isToday),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealText(String mealType, String meal, bool isToday) {
    return Text(
      '$mealType: $meal',
      style: TextStyle(
        fontSize: 14,
        color: isToday ? Colors.white : Colors.black,
      ),
    );
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  int get _daysInMonth {
    return DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
  }
}

class MealDetailsScreen extends StatelessWidget {
  final DateTime date;
  final Map<String, String> mealPlans;

  const MealDetailsScreen({
    Key? key,
    required this.date,
    required this.mealPlans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'Meal Plan for ${DateFormat('EEEE, MMM d').format(date)}',
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Breakfast: ${mealPlans['breakfast']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Lunch: ${mealPlans['lunch']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Dinner: ${mealPlans['dinner']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Snacks: ${mealPlans['snacks']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Back'),
            // ),
          ],
        ),
      ),
    );
  }
}
