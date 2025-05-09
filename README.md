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
Certifique-se de instalar o Flutter na versão **3.27.2** (ou superior). Siga os passos abaixo:

- [Guia oficial de instalação do Flutter](https://docs.flutter.dev/get-started/install)
- Após a instalação, verifique se o Flutter está configurado corretamente:
  ```bash
  flutter doctor
  ```

### 2. Clonar o Repositório
Clone este repositório em sua máquina local:
```bash
git clone https://github.com/ManoelASNeto/challenge_tpc.git
cd challenge_tpc
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

![Captura de Tela 2025-05-09 às 00 28 07](https://github.com/user-attachments/assets/c9fe4e77-9fcc-4f20-92b4-2cd0c10969c7)

---

## 📸 Prints ou Vídeo

### Tela de Lista de Tarefas
## iOS
<img width="300" alt="Screenshot 2025-05-08 at 23 55 55" src="https://github.com/user-attachments/assets/876d1aec-c833-41aa-b9b7-ca38cc4b6dc7" />
<img width="300" alt="Screenshot 2025-05-08 at 23 56 38" src="https://github.com/user-attachments/assets/92cb60b7-153f-4d8b-9159-7ebb56bc3258" />
<img width="300" alt="Screenshot 2025-05-08 at 23 56 59" src="https://github.com/user-attachments/assets/8b41a380-64ef-4f18-b06e-8fd98cb0e70f" />

## Android
<img width="300" alt="Captura de Tela 2025-05-09 às 00 34 59" src="https://github.com/user-attachments/assets/babe9818-cdb9-423c-a38a-fea0b6386d17" />
<img width="300" alt="Captura de Tela 2025-05-09 às 00 35 53" src="https://github.com/user-attachments/assets/c773a755-ae86-4ce8-a358-bcab62d29d07" />
<img width="300" alt="Captura de Tela 2025-05-09 às 00 37 09" src="https://github.com/user-attachments/assets/b43f2e91-944e-4605-9059-15314fee706c" />

### Tela de Tarefas Excluídas
## iOS
<img width="300" alt="Screenshot 2025-05-08 at 23 55 59" src="https://github.com/user-attachments/assets/8d54798d-a0e7-4158-976e-bf273b69ace0" />
<img width="300" alt="Screenshot 2025-05-08 at 23 57 30" src="https://github.com/user-attachments/assets/8fa2efaf-2ab3-4511-b82b-d8fface1b682" />
<img width="300" alt="Screenshot 2025-05-08 at 23 57 34" src="https://github.com/user-attachments/assets/58fc42f5-d2bd-4e65-b878-418d768545f4" />

## Android
<img width="300" alt="Captura de Tela 2025-05-09 às 00 37 34" src="https://github.com/user-attachments/assets/235939eb-9b9d-4fa8-a6c2-0c1478b42364" />
<img width="300" alt="Captura de Tela 2025-05-09 às 00 38 29" src="https://github.com/user-attachments/assets/bafeaf2a-c2a8-439f-96ef-49faecaf287c" />
<img width="300" alt="Captura de Tela 2025-05-09 às 00 38 50" src="https://github.com/user-attachments/assets/6a21f8b6-3975-4fbd-902a-2c3cbaabda08" />

---

## 📝 Conclusão

Este projeto é um exemplo de como criar um aplicativo de gerenciamento de tarefas com Flutter, utilizando o Hive para persistência de dados, o Cubit para gerenciamento de estado e o GetIt para injeção de dependências. A estrutura modular facilita a manutenção e escalabilidade do código.
```
