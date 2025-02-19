//
// Created by Kasper de bruin on 18/02/2025.
//

#ifndef APPLICATION_H
#define APPLICATION_H
#include <cstdint>
#include <iostream>
#include <GLFW/glfw3.h>
#include <vulkan/vulkan_core.h>
namespace d2t
{
	struct ApplicationSpecification
	{
		std::string Name   = "Data 2 Track Application";
		uint32_t	Width  = 1600;
		uint32_t	Height = 900;
	};

	class Application
	{
	public:
	// 	explicit Application(const ApplicationSpecification& applicationSpecification = ApplicationSpecification());
	// 	~Application();
	//
	// 	static Application& Get();
	//
	// 	void Run();
	// 	void SetMenubarCallback(const std::function<void()>& menubarCallback) { m_MenubarCallback = menubarCallback; }
	//
	// 	template <typename T>
	// 	void PushLayer()
	// 	{
	// 		static_assert(std::is_base_of<Layer, T>::value, "Pushed type is not subclass of Layer!");
	// 		m_LayerStack.emplace_back(std::make_shared<T>())->OnAttach();
	// 	}
	//
	// 	void PushLayer(const std::shared_ptr<Layer>& layer)
	// 	{
	// 		m_LayerStack.emplace_back(layer);
	// 		layer->OnAttach();
	// 	}
	//
	// 	void Close();
	//
	// 	float		GetTime();
	// 	GLFWwindow* GetWindowHandle() const { return m_WindowHandle; }
	//
	// 	static VkInstance		GetInstance();
	// 	static VkPhysicalDevice GetPhysicalDevice();
	// 	static VkDevice			GetDevice();
	//
	// 	static VkCommandBuffer GetCommandBuffer(bool begin);
	// 	static void			   FlushCommandBuffer(VkCommandBuffer commandBuffer);
	//
	// 	static void SubmitResourceFree(std::function<void()>&& func);
	//
	// private:
	// 	void Init();
	// 	void Shutdown();
	//
	// private:
	// 	ApplicationSpecification m_Specification;
	// 	GLFWwindow*				 m_WindowHandle = nullptr;
	// 	bool					 m_Running		= false;
	//
	// 	float m_TimeStep	  = 0.0f;
	// 	float m_FrameTime	  = 0.0f;
	// 	float m_LastFrameTime = 0.0f;
	//
	// 	std::vector<std::shared_ptr<Layer>> m_LayerStack;
	// 	std::function<void()>				m_MenubarCallback;
	};

} // namespace d2t

#endif // APPLICATION_H
