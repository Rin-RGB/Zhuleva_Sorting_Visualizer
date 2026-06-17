FROM ubuntu:24.04 AS build

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-tools-dev \
    catch2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN cmake -B build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build build
RUN ./build/tests/test_sorting


FROM ubuntu:24.04 AS runtime

RUN apt-get update && apt-get install -y \
    libqt6core6 \
    libqt6gui6 \
    libqt6qml6 \
    libqt6quick6 \
    libqt6quickcontrols2-6 \
    libx11-6 \
    libxcb1 \
    libxkbcommon-x11-0 \
    libgl1 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-xinerama0 \
    libxcb-xfixes0 \
    libdbus-1-3 \
    qml6-module-qtquick \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    qml6-module-qtquick-templates \
    qml6-module-qtquick-window \
    qml6-module-qtqml-workerscript\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/build/appsort_visualizer ./appsort_visualizer
COPY --from=build /app/build/tests/test_sorting ./tests/test_sorting

CMD ["./appsort_visualizer"]
