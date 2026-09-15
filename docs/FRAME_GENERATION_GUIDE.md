# Frame Generation Configuration Guide

## Intel Frame Generation (XeFG) для Gunnir A770 16GB

### Что такое Frame Generation?

Генерация кадров - это технология, которая авт��матически создает промежуточные кадры между отрендеренными кадрами:

- **Одиночная генерация**: 1 дополнительный кадр между каждой парой (30fps -> ~45fps)
- **Мульти-генерация**: 2-3 дополнительных кадра за раз (30fps -> 90-120fps)

### Frame Generation VS Frame Interpolation

**Frame Generation (XeFG)**:
- Создает полностью новые кадры
- Использует информацию о движении и геометрии
- XMX блоки для ускорения
- Более низкая задержка

**Frame Interpolation (GFI)**:
- Смешивает соседние кадры
- Более простой алгоритм
- Может быть 2x, 4x
- Больше чувствуется

### Активирование Frame Generation

```bash
# Простое включение
./tuning/frame-generation.sh enable

# Мульти-генерация (до 3 кадров)
./tuning/frame-generation.sh multi-frame

# Низкая задержка
./tuning/frame-generation.sh latency-optimized

# Высокое качество
./tuning/frame-generation.sh quality-optimized
```

### Deep Frame Synthesis (DFS)

Глубокий синтез кадров через нейронные сети:

```bash
# Базовое включение
./tuning/deep-frame-synthesis.sh enable

# Улучшенная оценка движения
./tuning/deep-frame-synthesis.sh neural-motion

# Максимальная производительность
./tuning/deep-frame-synthesis.sh ultra-performance

# Максимальное качество
./tuning/deep-frame-synthesis.sh ultra-quality
```

### Frame Interpolation (GFI)

Интерполяция кадров для плавного движения:

```bash
# Стандартная (1x кадр)
./tuning/frame-interpolation.sh standard

# Двойная частота кадров (60fps -> 120fps)
./tuning/frame-interpolation.sh double-frames

# Четырехкратная (30fps -> 120fps)
./tuning/frame-interpolation.sh quadruple-frames

# Оптический поток
./tuning/frame-interpolation.sh optical-flow

# AI-усовершенствованная
./tuning/frame-interpolation.sh ai-enhanced
```

### Полная оптимизация (All-in-One)

```bash
# Ultra профиль (все включено)
sudo ./tuning/game-optimization-complete.sh ultra

# Сбалансированный (рекомендуется)
sudo ./tuning/game-optimization-complete.sh balanced

# Производительность (максимум FPS)
sudo ./tuning/game-optimization-complete.sh performance

# Качество (максимум визуальной верности)
sudo ./tuning/game-optimization-complete.sh quality

# Esports (минимум задержки)
sudo ./tuning/game-optimization-complete.sh esports
```

### Использование в играх

#### Способ 1: Через переменные окружения

```bash
# Запуск с полной оптимизацией
Enable_FRAME_GEN=1 \
MULTI_FRAME_GEN=1 \
ENABLE_XMX=1 \
ENABLE_XESS=1 \
MANGOHUD=1 \
mangohud steam steam://run/GAME_ID
```

#### Способ 2: Через скрипт

```bash
#!/bin/bash
# Сохранить в файл game-launch.sh

# Применить профиль
source <(./tuning/game-optimization-complete.sh balanced)

# Запустить Steam
steam steam://run/GAME_ID
```

#### Способ 3: Через Steam Launch Options

В Steam -> Свойства игры -> Параметры запуска:

```bash
ENABLE_FRAME_GEN=1 MULTI_FRAME_GEN=1 ENABLE_XMX=1 MANGOHUD=1 %command%
```

### Рекомендуемые настройки для UE5 игр

#### Balanced (Рекомендуется)
```bash
# Для большинства UE5 игр
ENABLE_FRAME_GEN=1
MULTI_FRAME_GEN=1
MAX_GENERATED_FRAMES=1
FRAME_GEN_QUALITY=balanced
ENABLE_DFS=1
NEURAL_MOTION_ESTIMATION=1
ENABLE_GFI=1
GFI_FRAME_COUNT=1
```

#### Performance (Для старых/тяжелых игр)
```bash
ENABLE_FRAME_GEN=1
MULTI_FRAME_GEN=1
MAX_GENERATED_FRAMES=3
FRAME_GEN_QUALITY=performance
ENABLE_GFI=1
GFI_FRAME_COUNT=4
INTERPOLATION_MODE=4x
```

#### Quality (Для кинематических игр)
```bash
ENABLE_FRAME_GEN=1
FRAME_GEN_QUALITY=ultra
FRAME_GEN_PRECISION=fp32
ENABLE_DFS=1
DFS_QUALITY=ultra
DFS_PRECISION=fp32
ADVANCED_MOTION_ANALYSIS=1
```

### Мониторинг производительности

```bash
# Запустить игру с полным мониторингом
MANGOHUD=1 MGVER=100 steam steam://run/GAME_ID

# MangoHUD покажет:
# - GPU Load (%)
# - GPU Temperature (°C)
# - GPU Clock (MHz)
# - Memory Usage (GB из 16GB)
# - FPS
# - Frame Time (ms)
# - Generated Frames Count (если включена генерация)
```

### Параметры буферизации

Для оптимальной работы мульти-генерации:

```bash
# Буфер генерируемых кадров
export FRAME_GEN_BUFFER_SIZE=2048  # MB (для A770 16GB)
export FRAME_GEN_CACHE_SIZE=512    # MB

# Для интерполяции
export FRAME_CACHE_SIZE=1024  # MB
```

### Настройка качества генерации

**FP32 (Максимальное качество)**:
```bash
export DFS_PRECISION=fp32      # Полная точность
export FRAME_GEN_PRECISION=fp32
# Результат: Лучшее качество, больше вычислений
```

**FP16 (Оптимальный баланс)**:
```bash
export DFS_PRECISION=fp16      # Половинная точность
export FRAME_GEN_PRECISION=fp16
# Результат: Хорошее качество, быстрее
```

**INT8 (Максимальная производительность)**:
```bash
export DFS_PRECISION=int8      # Целые числа
export FAST_PATH_DFS=1
# Результат: Быстро, но может быть видны артефакты
```

### Решение проблем

#### Артефакты генерируемых кадров
```bash
# Увеличить качество
export ARTIFACT_REDUCTION_LEVEL=3
export TEMPORAL_COHERENCE=1
export EDGE_AWARE_SYNTHESIS=1
```

#### Высокая задержка
```bash
# Низкая задержка
export FRAME_GEN_LATENCY_MODE=ultra-low
export FG_LATENCY_TARGET=5
export NO_FRAME_SYNC=1
```

#### Низкий FPS даже с генерацией
```bash
# Проверить использование XMX
export ENABLE_XMX=1
export XMX_FRAME_GEN=1
# Проверить загрузку GPU
MANGOHUD=1 steam steam://run/GAME_ID
# Если GPU загрузка низкая - проблема в CPU
```

### Совместимость

- ✅ Unreal Engine 5 (все версии)
- ✅ Vulkan-based games
- ✅ DirectX через DXVK/VKD3D (с небольшой задержкой)
- ⚠️ OpenGL (ограниченная поддержка)
- ❌ Некоторые Proton games (проверить в ProtonDB)

### Windows Compatibility Mode

Для максимальной совместимости с Windows драйверами:

```bash
sudo ./tuning/windows-compat-mode.sh
# Активирует режим совместимости с Windows Intel Arc драйверами
```

---

**Версия**: 1.0  
**Для**: Intel Arc A770 16GB  
**ОС**: Arch Linux  
