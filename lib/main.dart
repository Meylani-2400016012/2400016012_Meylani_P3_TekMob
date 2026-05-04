import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Board',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const TaskBoardPage(),
    );
  }
}


enum TaskCategory { assignment, quiz, project, material, discussion }

enum TaskStatus { pending, inProgress, done }

class Task {
  final String id;
  final String title;
  final String description;
  final String dueLabel;
  final TaskCategory category;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueLabel,
    required this.category,
    this.status = TaskStatus.pending,
  });
}


List<Task> allTasks = [
  Task(
    id: '1',
    title: 'Layout Flutter Sederhana',
    description: 'Buat layout Row & Column dengan minimal 3 widget berbeda.',
    dueLabel: 'Besok',
    category: TaskCategory.assignment,
  ),
  Task(
    id: '2',
    title: 'Review Materi Row & Column',
    description: 'Baca ulang materi dan siapkan 2 pertanyaan untuk diskusi kelas.',
    dueLabel: 'Hari ini',
    category: TaskCategory.quiz,
  ),
  Task(
    id: '3',
    title: 'Tampilan Kartu List',
    description: 'Lengkapi tampilan kartu list dan rapikan warna komponen.',
    dueLabel: 'Jumat',
    category: TaskCategory.project,
  ),
  Task(
    id: '4',
    title: 'Widget Tree & Rendering',
    description: 'Pelajari cara Flutter membangun UI melalui pohon widget.',
    dueLabel: 'Minggu ini',
    category: TaskCategory.material,
  ),
  Task(
    id: '5',
    title: 'Diskusi: StatefulWidget',
    description: 'Bagikan pengalaman menggunakan setState dan kapan diperlukan.',
    dueLabel: 'Kamis 15:00',
    category: TaskCategory.discussion,
  ),
  Task(
    id: '6',
    title: 'ListView.builder Practice',
    description: 'Implementasi ListView.builder dengan data dummy lebih dari 10 item.',
    dueLabel: 'Jumat',
    category: TaskCategory.assignment,
  ),
  Task(
    id: '7',
    title: 'Quiz: Stateless vs Stateful',
    description: 'Jawab 10 soal pilihan ganda tentang perbedaan kedua widget.',
    dueLabel: 'Senin',
    category: TaskCategory.quiz,
  ),
  Task(
    id: '8',
    title: 'Mini Project: Profile Card',
    description: 'Buat halaman profil menggunakan Column, Row, dan CircleAvatar.',
    dueLabel: 'Pekan depan',
    category: TaskCategory.project,
  ),
  Task(
    id: '9',
    title: 'Baca: Flutter Navigation',
    description: 'Pelajari Navigator 2.0 dan konsep named routes pada Flutter.',
    dueLabel: 'Sebelum kelas',
    category: TaskCategory.material,
  ),
  Task(
    id: '10',
    title: 'Forum: Tips Expanded Widget',
    description: 'Bagikan tips penggunaan Expanded vs Flexible di forum kelas.',
    dueLabel: 'Terbuka',
    category: TaskCategory.discussion,
  ),
  Task(
    id: '11',
    title: 'Styling & BoxDecoration',
    description: 'Terapkan borderRadius, boxShadow, dan gradient pada Container.',
    dueLabel: 'Rabu',
    category: TaskCategory.assignment,
  ),
  Task(
    id: '12',
    title: 'UTS Mini Project',
    description: 'Kumpulkan semua latihan dan buat satu app sederhana untuk UTS.',
    dueLabel: '2 Minggu lagi',
    category: TaskCategory.project,
  ),
];

class CategoryConfig {
  final Color color;
  final Color lightColor;
  final Color textColor;
  final IconData icon;
  final String label;

  const CategoryConfig({
    required this.color,
    required this.lightColor,
    required this.textColor,
    required this.icon,
    required this.label,
  });
}

const Map<TaskCategory, CategoryConfig> categoryConfig = {
  TaskCategory.assignment: CategoryConfig(
    color: Color(0xFF6C63FF),
    lightColor: Color(0xFFEEEDFE),
    textColor: Color(0xFF3C3489),
    icon: Icons.edit_note_rounded,
    label: 'Assignment',
  ),
  TaskCategory.quiz: CategoryConfig(
    color: Color(0xFF0F9D58),
    lightColor: Color(0xFFE1F5EE),
    textColor: Color(0xFF085041),
    icon: Icons.quiz_rounded,
    label: 'Quiz',
  ),
  TaskCategory.project: CategoryConfig(
    color: Color(0xFFEF9F27),
    lightColor: Color(0xFFFAEEDA),
    textColor: Color(0xFF633806),
    icon: Icons.folder_special_rounded,
    label: 'Project',
  ),
  TaskCategory.material: CategoryConfig(
    color: Color(0xFF378ADD),
    lightColor: Color(0xFFE6F1FB),
    textColor: Color(0xFF0C447C),
    icon: Icons.menu_book_rounded,
    label: 'Materi',
  ),
  TaskCategory.discussion: CategoryConfig(
    color: Color(0xFFE24B4A),
    lightColor: Color(0xFFFCEBEB),
    textColor: Color(0xFF791F1F),
    icon: Icons.forum_rounded,
    label: 'Diskusi',
  ),
};


void showTaskDetail(BuildContext context, Task task, VoidCallback onChanged) {
  final cfg = categoryConfig[task.category]!;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => StatefulBuilder(
      builder: (ctx, setSheetState) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: cfg.lightColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cfg.icon, size: 14, color: cfg.color),
                  const SizedBox(width: 5),
                  Text(
                    cfg.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: cfg.textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Text(
              task.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Due date row
            Row(
              children: [
                const Icon(Icons.schedule_rounded,
                    size: 16, color: Color(0xFF9CA3AF)),
                const SizedBox(width: 6),
                Text(
                  'Tenggat: ${task.dueLabel}',
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Status selector label
            const Text(
              'Ubah Status',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: TaskStatus.values.map((s) {
                final isSelected = task.status == s;
                final labels = {
                  TaskStatus.pending: 'Belum Mulai',
                  TaskStatus.inProgress: 'Dikerjakan',
                  TaskStatus.done: 'Selesai',
                };
                final colors = {
                  TaskStatus.pending: const Color(0xFF9CA3AF),
                  TaskStatus.inProgress: const Color(0xFFEF9F27),
                  TaskStatus.done: const Color(0xFF0F9D58),
                };
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setSheetState(() => task.status = s);
                      onChanged();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: s != TaskStatus.done ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors[s]!.withOpacity(0.12)
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? colors[s]!
                              : const Color(0xFFE5E7EB),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        labels[s]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? colors[s]
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Tutup',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


class TaskBoardPage extends StatefulWidget {
  const TaskBoardPage({super.key});

  @override
  State<TaskBoardPage> createState() => _TaskBoardPageState();
}

class _TaskBoardPageState extends State<TaskBoardPage> {
  TaskCategory? _selectedFilter;

  List<Task> get filteredTasks => _selectedFilter == null
      ? allTasks
      : allTasks.where((t) => t.category == _selectedFilter).toList();

  int get doneCount =>
      allTasks.where((t) => t.status == TaskStatus.done).length;
  int get inProgressCount =>
      allTasks.where((t) => t.status == TaskStatus.inProgress).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Column(
        children: [
          _Header(
            doneCount: doneCount,
            inProgressCount: inProgressCount,
            total: allTasks.length,
          ),

          _FilterRow(
            selected: _selectedFilter,
            onSelect: (cat) => setState(() {
              _selectedFilter = _selectedFilter == cat ? null : cat;
            }),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return _TaskCard(
                  task: task,
                  onTap: () => showTaskDetail(
                    context,
                    task,
                    () => setState(() {}),
                  ),
                  onStatusToggle: () => setState(() {
                    task.status = task.status == TaskStatus.done
                        ? TaskStatus.pending
                        : TaskStatus.done;
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int doneCount;
  final int inProgressCount;
  final int total;

  const _Header({
    required this.doneCount,
    required this.inProgressCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pending = total - doneCount - inProgressCount;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF6C63FF),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Daftar Tugas Mahasiswa',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Task Board',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              _StatChip(
                  label: 'Total',
                  value: total,
                  color: Colors.white),
              const SizedBox(width: 8),
              _StatChip(
                  label: 'Selesai',
                  value: doneCount,
                  color: const Color(0xFF4ADE80)),
              const SizedBox(width: 8),
              _StatChip(
                  label: 'Proses',
                  value: inProgressCount,
                  color: const Color(0xFFFBBF24)),
              const SizedBox(width: 8),
              _StatChip(
                  label: 'Pending',
                  value: pending,
                  color: Colors.white54),
            ],
          ),

          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress keseluruhan',
                    style:
                        TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    '${total == 0 ? 0 : (doneCount * 100 ~/ total)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : doneCount / total,
                  minHeight: 6,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF4ADE80)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style:
                  const TextStyle(color: Colors.white60, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}


class _FilterRow extends StatelessWidget {
  final TaskCategory? selected;
  final ValueChanged<TaskCategory> onSelect;

  const _FilterRow({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: TaskCategory.values.map((cat) {
          final cfg = categoryConfig[cat]!;
          final isSelected = selected == cat;
          return GestureDetector(
            onTap: () => onSelect(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? cfg.color : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? cfg.color
                      : const Color(0xFFE5E7EB),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: cfg.color.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cfg.icon,
                    size: 14,
                    color: isSelected ? Colors.white : cfg.color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cfg.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected ? Colors.white : cfg.textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onStatusToggle;

  const _TaskCard({
    required this.task,
    required this.onTap,
    required this.onStatusToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = categoryConfig[task.category]!;
    final isDone = task.status == TaskStatus.done;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: isDone
                    ? const Color(0xFFD1FAE5)
                    : cfg.color,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFFD1FAE5)
                              : cfg.lightColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: isDone
                              ? const Icon(Icons.check_rounded,
                                  size: 20,
                                  color: Color(0xFF0F9D58))
                              : Icon(cfg.icon,
                                  size: 20, color: cfg.color),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDone
                                    ? const Color(0xFFB0B8C1)
                                    : const Color(0xFF1A1A2E),
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 12,
                                  color: isDone
                                      ? const Color(0xFFB0B8C1)
                                      : const Color(0xFF9CA3AF),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.dueLabel,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDone
                                        ? const Color(0xFFB0B8C1)
                                        : const Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: onStatusToggle,
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isDone
                                ? const Color(0xFF0F9D58)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isDone
                                  ? const Color(0xFF0F9D58)
                                  : const Color(0xFFD1D5DB),
                              width: 2,
                            ),
                          ),
                          child: isDone
                              ? const Icon(Icons.check_rounded,
                                  size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDone
                          ? const Color(0xFFB0B8C1)
                          : const Color(0xFF6B7280),
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFFF3F4F6)
                              : cfg.lightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          cfg.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDone
                                ? const Color(0xFFB0B8C1)
                                : cfg.textColor,
                          ),
                        ),
                      ),

                      if (task.status == TaskStatus.inProgress) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Dikerjakan',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ],

                      const Spacer(),

                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5FA),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Detail',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
                                color: Color(0xFF6C63FF),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}