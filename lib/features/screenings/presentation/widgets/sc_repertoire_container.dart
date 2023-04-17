import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_list_item.dart';

class SCRepertoireContainer extends StatelessWidget {
  const SCRepertoireContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 525,
      color: Theme.of(context).colorScheme.onBackground,
      padding: const EdgeInsets.symmetric(vertical: 17),
      child: BlocBuilder<RepertoireBloc, RepertoireState>(
        builder: (context, state) {
          if (state is RepertoireLoaded) {
            return Column(
              children: state.repertoireList.map((repertoire) {
                return SCRepertoireListItem(
                    repertoire: repertoire);
              }).toList(),
            );
          } else if (state is RepertoireLoading) {
            return const Center(
                child: CircularProgressIndicator());
          } else if (state is RepertoireError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Empty'));
          }
        },
      ),
    );
  }
}