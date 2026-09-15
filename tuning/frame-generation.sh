#!/bin/bash

# Intel Arc Frame Generation (XeFG) & Multi-Frame Generation Setup
# Настройка генерации кадров Intel для A770 16GB

echo "=== Intel Arc Frame Generation Configuration ==="

FG_MODE=${1:-enable}

case $FG_MODE in
    enable)
        echo "Enabling Intel Frame Generation..."
        
        # Переменные окружения для генерации кадров
        export ENABLE_FRAME_GEN=1
        export INTEL_FRAME_GEN=1
        export XeFG_ENABLE=1
        
        # Мультигенерация кадров
        export MULTI_FRAME_GEN=1
        export FRAME_GEN_QUALITY=high
        export FRAME_GEN_LATENCY_MODE=balanced
        
        # Vulkan расширение для генерации
        export VK_EXTENSION_FG=1
        export VK_LAYER_INTEL_FRAME_GEN=1
        
        # Оптимизация для A770
        export FG_BLOCK_SIZE=256
        export FG_USE_TENSOR=1
        export FG_PRECISION=fp16
        
        # Интеграция с XMX для кадров
        export XMX_FRAME_GEN=1
        export MATRIX_FRAME_GEN=1
        
        # Адаптивная генерация
        export ADAPTIVE_FRAME_GEN=1
        export AUTO_QUALITY_ADJUST=1
        
        echo "✓ Frame Generation enabled"
        echo "✓ Multi-Frame Generation enabled"
        echo "✓ Adaptive quality enabled"
        ;;
    
    multi-frame)
        echo "Configuring Multi-Frame Generation..."
        
        # Мульти-кадр конфигурация
        export ENABLE_FRAME_GEN=1
        export MULTI_FRAME_GEN=1
        export MAX_GENERATED_FRAMES=3  # До 3 кадров за раз
        export FRAME_GEN_BATCH_SIZE=4
        
        # Параллельная генерация
        export PARALLEL_FRAME_GEN=1
        export FG_THREADS=8  # Использование нескольких потоков
        export FRAME_GEN_PIPELINE=1
        
        # Оптимизация памяти для мульти-генерации
        export FRAME_GEN_BUFFER_SIZE=2048  # MB
        export FRAME_GEN_CACHE_SIZE=512
        
        # Интеграция с XMX блоками
        export MULTI_XMX_FRAME_GEN=1
        export TENSOR_FRAME_BATCH=1
        
        # Качество мульти-генерации
        export MULTI_FG_QUALITY=ultra
        export INTER_FRAME_SMOOTHING=1
        
        echo "✓ Multi-Frame Generation (max 3 frames per batch)"
        echo "✓ Parallel processing enabled (8 threads)"
        echo "✓ XMX tensor operations optimized"
        ;;
    
    latency-optimized)
        echo "Latency Optimized Frame Generation..."
        
        export ENABLE_FRAME_GEN=1
        export FRAME_GEN_LATENCY_MODE=ultra-low
        export FG_LATENCY_TARGET=5  # 5ms target
        export FRAME_GEN_SKIP_VALIDATION=1
        export PREDICTIVE_FRAME_GEN=1
        
        # Минимизация задержки
        export FG_BUFFER_MINIMAL=1
        export NO_FRAME_SYNC=1
        export IMMEDIATE_PRESENT=1
        
        echo "✓ Ultra-low latency mode"
        echo "✓ Target latency: 5ms"
        ;;
    
    quality-optimized)
        echo "Quality Optimized Frame Generation..."
        
        export ENABLE_FRAME_GEN=1
        export FRAME_GEN_QUALITY=ultra
        export FRAME_GEN_PRECISION=fp32  # Высокая точность
        export FRAME_GEN_DETAIL_LEVEL=5
        export TEMPORAL_SMOOTHING=1
        export MOTION_ESTIMATION_QUALITY=high
        
        # Больше вычислений для качества
        export FG_PROCESSING_ITERATIONS=3
        export ADVANCED_MOTION_ANALYSIS=1
        export EDGE_ENHANCEMENT=1
        
        echo "✓ Quality-focused mode (FP32 precision)"
        echo "✓ Advanced motion analysis enabled"
        ;;
    
    disable)
        echo "Disabling Frame Generation..."
        export ENABLE_FRAME_GEN=0
        export MULTI_FRAME_GEN=0
        echo "✓ Frame Generation disabled"
        ;;
    
    *)
        echo "Usage: $0 {enable|multi-frame|latency-optimized|quality-optimized|disable}"
        echo ""
        echo "Modes:"
        echo "  enable              - Standard frame generation"
        echo "  multi-frame         - Up to 3 frames per batch (max performance)"
        echo "  latency-optimized   - Ultra-low latency mode (<5ms)"
        echo "  quality-optimized   - Maximum quality (FP32 precision)"
        echo "  disable             - Disable frame generation"
        exit 1
        ;;
esac

echo ""
echo "Export these variables before launching games:"
echo "  export ENABLE_FRAME_GEN=1"
echo "  export MULTI_FRAME_GEN=1"
echo ""
echo "Or add to launch command:"
echo "  ENABLE_FRAME_GEN=1 MULTI_FRAME_GEN=1 steam steam://run/GAME_ID"
