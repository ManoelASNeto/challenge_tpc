# Task Management App

Este é um aplicativo de gerenciamento de tarefas desenvolvido em **Flutter**. Ele utiliza o **Hive** como banco de dados local para armazenar e gerenciar as tarefas. O projeto segue uma arquitetura modular e bem organizada, com uso do **Cubit** (via `flutter_bloc`) para gerenciamento de estado e o **GetIt** para injeção de dependências.

---

## 📦 Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
lib/
├── core/
│   ├── utils/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── apps_animation.dart
│   │   └── theme_extensions.dart
├── features/
│   ├── task/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── task_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── task_model.dart
│   │   │   └── repositories/
│   │   │       └── task_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── task_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── task_repository.dart
│   │   │   └── usecases/
│   │   │       ├── add_task_usecase.dart
│   │   │       ├── deleted_all_tasks_usecase.dart
│   │   │       ├── get_all_task_usecase.dart
│   │   │       └── update_task_usecase.dart
│   │   ├── presentation/
│   │   │   ├── cubit/
│   │   │   │   ├── task_cubit.dart
│   │   │   │   └── task_state.dart
│   │   │   ├── pages/
│   │   │   │   ├── task_list_page.dart
│   │   │   │   └── tasks_deleted_page.dart
```

---

## 🚀 Como Instalar o Flutter e Rodar o Projeto

### 1. Instalar o Flutter
Certifique-se de instalar o Flutter na versão **3.10.5** (ou superior). Siga os passos abaixo:

- [Guia oficial de instalação do Flutter](https://docs.flutter.dev/get-started/install)
- Após a instalação, verifique se o Flutter está configurado corretamente:
  ```bash
  flutter doctor
  ```

### 2. Clonar o Repositório
Clone este repositório em sua máquina local:
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

### 3. Instalar Dependências
Rode o comando abaixo para instalar todas as dependências do projeto:
```bash
flutter pub get
```

### 4. Rodar o Projeto
Para rodar o projeto em um dispositivo ou emulador:
```bash
flutter run
```

---

## 🛠️ Uso de GetIt e Cubit

### **GetIt**
O **GetIt** é usado para gerenciar a injeção de dependências no projeto. Ele facilita o registro e a recuperação de instâncias de classes, como repositórios e casos de uso.

**Exemplo de Configuração:**
```dart
final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskLocalDatasource: getIt()));
  getIt.registerLazySingleton<AddTaskUsecase>(() => AddTaskUsecase(taskRepository: getIt()));
}
```

### **Cubit**
O **Cubit** é usado para gerenciar o estado das telas. Ele é uma solução simples e eficiente para lidar com estados no Flutter.

**Exemplo de Cubit:**
```dart
class TaskCubit extends Cubit<TaskState> {
  final AddTaskUsecase addTaskUsecase;

  TaskCubit(this.addTaskUsecase) : super(TaskInitial());

  Future<void> addTask(TaskEntity task) async {
    try {
      await addTaskUsecase.call(task);
      emit(TaskLoaded(tasks: [task]));
    } catch (e) {
      emit(TaskError(msgError: e.toString()));
    }
  }
}
```

---

## 🧪 Como Rodar os Testes e Cobertura de Testes

### 1. Rodar os Testes
Para rodar todos os testes do projeto, use o comando:
```bash
flutter test
```

### 2. Gerar Cobertura de Testes
Para gerar a cobertura de testes com o **lcov**, siga os passos abaixo:

1. Instale o `lcov` (caso ainda não tenha):
   ```bash
   sudo apt-get install lcov # Para Linux
   brew install lcov         # Para macOS
   ```

2. Rode os testes com cobertura:
   ```bash
   flutter test --coverage
   ```

3. Gere o relatório de cobertura:
   ```bash
   genhtml coverage/lcov.info -o coverage/html
   ```

4. Abra o relatório no navegador:
   ```bash
   open coverage/html/index.html
   ```

---

## 📸 Prints ou Vídeo

### Tela de Lista de Tarefas
![Task List Page](https://via.placeholder.com/800x400?text=Task+List+Page)

### Tela de Tarefas Excluídas
![Tasks Deleted Page](https://via.placeholder.com/800x400?text=Tasks+Deleted+Page)

---

## 📝 Conclusão

Este projeto é um exemplo de como criar um aplicativo de gerenciamento de tarefas com Flutter, utilizando o Hive para persistência de dados, o Cubit para gerenciamento de estado e o GetIt para injeção de dependências. A estrutura modular facilita a manutenção e escalabilidade do código.
```