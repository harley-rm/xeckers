workspace "xeckers"
    architecture "x64"
    startproject "Sandbox"

    configurations { 
        "Debug",
        "Release"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


project "xeckers"
    location "xeckers"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "xeckerspch.h"
    pchsource "xeckers/src/xeckerspch.cpp"

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include"
    }

    filter "system:windows"
        systemversion "latest"

        defines {
            "XECKERS_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "XECKERS_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "XECKERS_RELEASE"
        runtime "Release"
        optimize "on"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs {
        "%{prj.name}/vendor/spdlog/include"
    }

    links {
        "xeckers"
    }

    filter "system:windows"
        systemversion "latest"

        defines {
            "XECKERS_PLATFORM_WINDOWS"
        }
    
    filter "configurations:Debug"
        defines "XECKERS_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "XECKERS_RELEASE"
        runtime "Release"
        optimize "on"