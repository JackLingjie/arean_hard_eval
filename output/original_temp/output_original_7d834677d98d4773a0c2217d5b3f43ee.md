**Getting CPU and RAM Usage of Running Processes**

Below is a VB.NET function that retrieves the CPU and RAM usage of every process running on the computer.

### Code

```vbnet
Imports System.Diagnostics
Imports System.Collections.Generic

Public Class ProcessInfo
    Public Property Name As String
    Public Property RamUsage As Double
    Public Property CpuUsage As Double
End Class

Public Function GetProcessUsage() As List(Of ProcessInfo)
    Dim processList As New List(Of ProcessInfo)

    ' Get all running processes
    For Each proc As Process In Process.GetProcesses()
        Try
            ' Get process details
            Dim processInfo As New ProcessInfo
            processInfo.Name = proc.ProcessName

            ' Get RAM usage
            Dim ramUsage As Double = GetRamUsage(proc.Id)

            ' Get CPU usage
            Dim cpuUsage As Double = GetCpuUsage(proc.Id)

            processInfo.RamUsage = ramUsage
            processInfo.CpuUsage = cpuUsage

            processList.Add(processInfo)
        Catch ex As Exception
            ' Handle exceptions
            Console.WriteLine($"Error processing {proc.ProcessName}: {ex.Message}")
        End Try
    Next

    Return processList
End Function

Private Function GetRamUsage(processId As Integer) As Double
    Dim process As Process = Process.GetProcessById(processId)
    Dim workingSet64 As Long = process.WorkingSet64
    Return workingSet64 / (1024 * 1024) ' Convert bytes to MB
End Function

Private Function GetCpuUsage(processId As Integer) As Double
    Dim process As Process = Process.GetProcessById(processId)
    Dim cpuUsage As Double = process.TotalProcessorTime.TotalSeconds
    Return cpuUsage
End Function
```

### Explanation

- **`GetProcessUsage` Function**: This function iterates over all running processes, retrieves their details, and calculates their RAM and CPU usage.
- **`ProcessInfo` Class**: Represents a process with properties for its name, RAM usage, and CPU usage.
- **`GetRamUsage` Function**: Calculates the RAM usage of a process by its ID.
- **`GetCpuUsage` Function**: Calculates the CPU usage of a process by its ID.

### Example Use Case

```vbnet
Dim processUsage As List(Of ProcessInfo) = GetProcessUsage()

For Each process In processUsage
    Console.WriteLine($"Process: {process.Name}")
    Console.WriteLine($"RAM Usage: {process.RamUsage} MB")
    Console.WriteLine($"CPU Usage: {process.CpuUsage} seconds")
    Console.WriteLine()
Next
```

This example demonstrates how to use the `GetProcessUsage` function to retrieve the CPU and RAM usage of all running processes and print the results.