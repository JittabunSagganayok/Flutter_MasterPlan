import 'package:flutter/material.dart';
import 'package:master_plan/plan_provider.dart';
import 'package:master_plan/views/plan_page.dart';

class PlanCreatorPage extends StatefulWidget {
  final String title;

  const PlanCreatorPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return PlanCreatorPageState();
  }
}

class PlanCreatorPageState extends State<PlanCreatorPage> {
  final _nameEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            _buildPlanForm(context),
            Expanded(
              child: _buildPlanList(),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildPlanForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: _nameEditingController,
          decoration: const InputDecoration(
            labelText: 'Add a plan',
            contentPadding: EdgeInsets.all(20),
          ),
          onEditingComplete: addPlan,
        ),
      ),
    );
  }

  void addPlan() {
    final name = _nameEditingController.text;
    if (name.isEmpty) {
      return;
    }
    PlanProvider.of(context).addNewPlan(name);
    _nameEditingController.clear();
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  Widget _buildPlanList() {
    final plans = PlanProvider.of(context).plans;
    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'You do not have any plans yet.',
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      );
    }
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return Dismissible(
          key: ValueKey(plan),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            PlanProvider.of(context).deletePlan(plan);
          },
          child: ListTile(
            title: Text(plan.name),
            subtitle: Text(plan.completenessMessage),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlanPage(plan: plan)));

              if (!mounted) {
                return;
              }

              setState(() {});
            },
          ),
        );
      },
    );
  }
}
